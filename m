Received: from eggs.gnu.org ([2001:4830:134:3::10]:44689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1eKQpx-0005VG-0H
	for Qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1eKQpr-0007a5-LN
	for Qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:33:17 -0500
Date: Thu, 30 Nov 2017 16:32:13 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20171130153213.GB11253@grep.be>
References: <15f2fce6-00f4-0c1d-4ebe-d4ed7c5e7596@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f2fce6-00f4-0c1d-4ebe-d4ed7c5e7596@redhat.com>
Subject: Re: [Qemu-devel] RFC: Let NBD client request read-only mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: nbd list <nbd@other.debian.org>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Wed, Nov 29, 2017 at 08:57:20AM -0600, Eric Blake wrote:
> Right now, only the server can choose whether an export is read-only.  A
> client can always treat an export as read-only by not sending any writes,
> but a server has no guarantee that a client will behave that way, and must
> assume that an export where the server did not advertise NBD_FLAG_READ_ONLY
> will modify the export.  Therefore, if the server does not want to permit
> simultaneous modifications to the underlying data, it has the choice of
> either permitting only one client at a time, or supporting multiple
> connections but enforcing all subsequent connections to see the
> NBD_FLAG_READ_ONLY bit on the export that is already in use by the first
> connection (note that this is racy - whoever connects first is the only one
> that can get write permissions, even if the first connected client doesn't
> want to write).
> 
> However, at least qemu has a case where it would be nice to permit a
> parallel known-read-only client from the same server that is (or will be)
> handling a read-write client; and what's more, to make it so that the
> read-only client can win the race of being the first connection without
> penalizing the actual read-write connection (see
> https://bugzilla.redhat.com/show_bug.cgi?id=1518543).

Right, I can see the dilemma.

(a possible workaround could be that the server could have two versions of the
same export, one which is marked read-only and one which is not, but that is a
bit ugly)

> I don't see any way to accomplish this with oldstyle negotiation (but that
> doesn't matter these days); but with newstyle negotiation, there are at least
> two possible implementations:
> 
> Idea 1: the server advertises a new global bit NBD_FLAG_NO_WRITE (ideas for
> a better name?) in its 16-bit handshake flags; if the client replies with
> the same bit set (documentation-wise, we'd name the client reply
> NBD_FLAG_C_NO_WRITE), then the server knows that the client promises to be a
> read-only connection.

I'd rather not burn a global bit for this.

> Idea 2: we add a new option, NBD_OPT_READ_ONLY.  If the client sends this
> option, and the server replies with NBD_REP_ACK, then the server knows that
> the client promises to be a read-only connection.
> 
> With either idea, once the server knows the client's intent to be a
> read-only client, the server SHOULD set NBD_FLAG_READ_ONLY on all (further)
> information sent for any export (whether from NBD_OPT_EXPORT_NAME,
> NBD_OPT_INFO, or NBD_OPT_GO) and treat any export as read-only for the
> current client, even if that export is in parallel use by another read-write
> client, and the client MUST NOT send NBD_CMD_WRITE, NBD_CMD_TRIM,
> NBD_CMD_WRITE_ZEROES, or any other command that requires a writable
> connection (the NBD_CMD_RESIZE extension comes to mind).

Right.

> A client that wants to be read-only, but which does not see server support
> (in idea 1, the server did not advertise the bit; in idea 2, the server
> replies with NBD_REP_ERR_UNSUP), does not have to do anything special (it is
> always possible to do just reads to a read-write connection, and the server
> may still set NBD_FLAG_READ_ONLY even without supporting the extension of
> permitting a client-side request).  But such a client may, if it wants to be
> nice to potential parallel writers on the same export, decide to disconnect
> quickly (with NBD_OPT_ABORT or NBD_CMD_DISC as appropriate) rather than tie
> up a read-write connection.

Indeed.

> I don't know which idea is more palatable.  We have a finite set of only 2^4
> global handshake flags because it is a bitmask, where only 14 bits remain;
> whereas we have almost 2^32 potential NBD_OPT_ values.  On the other hand,
> using a global handshake flag means the server never shows any export as
> writable; while with the NBD_OPT_ solution, a guest can get different
> results for the sequence NBD_OPT_INFO, NBD_OPT_READ_ONLY, NBD_OPT_INFO.

It might additionally also be a good idea to add another data item to
the NBD_OPT_INFO response which tells the client that it will be the
only writer, but that there may be other readers.

That way, if a client sees that data item, it could go "oh, but I don't
need to write -- here's an NBD_OPT_READ_ONLY for you".

> There's also the question with option 2 of whether permitting
> NBD_OPT_READ_ONLY prior to NBD_OPT_STARTTLS would make sense (is there any
> case where the set of TLS authentication to be performed can involve looser
> requirements for a known-read-only client?),

Yes, but if a server wants to allow writing to a device based on whether
a client is authenticated or not, then all it needs to do is to set the
read-only flag based on whether that client is authenticated or not.

It might still be useful to signal to a client somehow that it could get
more rights if it provided authentication credentials of some sort, but
that is not entirely related to whether or not a client declares that it
will write to the device

> where using a global bit makes the sequence of required NBD_OPT_* a
> bit less stateful.
> 
> Does the idea sound reasonable enough to propose wording to add it to the
> NBD spec and an implementation in qemu?  Which of the two ideas is preferred
> for letting the client inform the server of its intent?

I think it sounds reasonable enough, yes; but I also think there are a
few other related situations that might be relevant enough to warrant
thinking about more. I gave a few examples above, but maybe there are
more? Dunno.

-- 
Could you people please use IRC like normal people?!?

  -- Amaya Rodrigo Sastre, trying to quiet down the buzz in the DebConf 2008
     Hacklab
