Received: from eggs.gnu.org ([2001:4830:134:3::10]:53255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKRGe-0007Df-TS
	for Qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKRGb-00013F-1X
	for Qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:00:53 -0500
References: <15f2fce6-00f4-0c1d-4ebe-d4ed7c5e7596@redhat.com>
	<20171130153213.GB11253@grep.be>
From: Eric Blake <eblake@redhat.com>
Message-ID: <507b0c8e-d8be-9468-51cf-951dd897cc01@redhat.com>
Date: Thu, 30 Nov 2017 10:00:46 -0600
MIME-Version: 1.0
In-Reply-To: <20171130153213.GB11253@grep.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] RFC: Let NBD client request read-only mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: nbd list <nbd@other.debian.org>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On 11/30/2017 09:32 AM, Wouter Verhelst wrote:

>> A client that wants to be read-only, but which does not see server support
>> (in idea 1, the server did not advertise the bit; in idea 2, the server
>> replies with NBD_REP_ERR_UNSUP), does not have to do anything special (it is
>> always possible to do just reads to a read-write connection, and the server
>> may still set NBD_FLAG_READ_ONLY even without supporting the extension of
>> permitting a client-side request).  But such a client may, if it wants to be
>> nice to potential parallel writers on the same export, decide to disconnect
>> quickly (with NBD_OPT_ABORT or NBD_CMD_DISC as appropriate) rather than tie
>> up a read-write connection.
> 
> Indeed.
> 
>> I don't know which idea is more palatable.  We have a finite set of only 2^4
>> global handshake flags because it is a bitmask, where only 14 bits remain;
>> whereas we have almost 2^32 potential NBD_OPT_ values.  On the other hand,
>> using a global handshake flag means the server never shows any export as
>> writable; while with the NBD_OPT_ solution, a guest can get different
>> results for the sequence NBD_OPT_INFO, NBD_OPT_READ_ONLY, NBD_OPT_INFO.
> 
> It might additionally also be a good idea to add another data item to
> the NBD_OPT_INFO response which tells the client that it will be the
> only writer, but that there may be other readers.
> 
> That way, if a client sees that data item, it could go "oh, but I don't
> need to write -- here's an NBD_OPT_READ_ONLY for you".

There's also the question of inconsistent reads - normally, if a client 
is the only reader, the client can cache data rather than having to 
re-read it from the server; whereas if there is another writer in 
parallel, the client SHOULD read data again rather than relying on the 
cache (since the other writer may have changed data in the meantime) - 
so maybe having a way for the server to report whether reads may be 
inconsistent, or even give an error to NBD_OPT_GO unless the client 
requests (via NBD_OPT_READ_ONLY or some other way) that the client is 
aware of the potential for volatile/inconsistent reads.

> I think it sounds reasonable enough, yes; but I also think there are a
> few other related situations that might be relevant enough to warrant
> thinking about more. I gave a few examples above, but maybe there are
> more? Dunno.

Okay, sounds like it warrants enough potential for conversation that I 
should write it up as a patch, and the patch may need a new extension- 
branch rather than going straight into mainline; and I'll stick with 
idea 2 (NBD_OPT_READ_ONLY) rather than burning a global handshake bit. 
I hope to give the documentation patch a shot in the next few days.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
