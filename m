Received: from eggs.gnu.org ([2001:4830:134:3::10]:42467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHFhD-0005Ey-Vt
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHFhC-0006VN-PW
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:58:36 -0500
Date: Wed, 14 Dec 2016 20:58:11 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161214195811.zy44uin4o34nvgjp@grep.be>
References: <20161205234235.5728-1-eblake@redhat.com>
	<20161212181237.3aymdmenxeu2kwjj@grep.be>
	<20161213073812.GA4443@noname.str.redhat.com>
	<20161213121856.b7fmjwjfkoeufz4g@grep.be>
	<f354bb95-fcbe-c59d-d5b1-479d76764d9d@redhat.com>
	<20161214082246.dwzqsu3tzmjmiem6@grep.be>
	<0376b5a6-8840-48aa-d1f2-d72c6b570f6d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0376b5a6-8840-48aa-d1f2-d72c6b570f6d@redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, nbd-general@lists.sourceforge.net, subo7@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, xieyingtai@huawei.com, pbonzini@redhat.com

Hi Eric,

On Wed, Dec 14, 2016 at 10:37:43AM -0600, Eric Blake wrote:
> On 12/14/2016 02:22 AM, Wouter Verhelst wrote:
> > Hi Eric,
> > 
> > On Tue, Dec 13, 2016 at 04:36:08PM -0600, Eric Blake wrote:
> >> On 12/13/2016 06:18 AM, Wouter Verhelst wrote:
> >>> On Tue, Dec 13, 2016 at 08:38:12AM +0100, Kevin Wolf wrote:
> >>>> Am 12.12.2016 um 19:12 hat Wouter Verhelst geschrieben:
> >>>>> I'm not opposed to this proposal, per se, but there seems to be some
> >>>>> disagreement (by Kevin, for instance) on whether this extension is at
> >>>>> all useful.
> >>>>
> >>>> FWIW, I'm not opposed to adding the flag. I don't think it can hurt, but
> >>>> I wanted to ask the question so that we don't end up adding a feature
> >>>> that noone actually uses. Ultimately it's your call as a maintainer
> >>>> anyway how conservative you want to be with spec additions.
> >>>
> >>> I'm not opposed either, but I do agree with you that we shouldn't add
> >>> such a feature if it doesn't end up getting used. Especially so if it
> >>> burns a flag in the (16-bit) "transmission flags" field, where space is
> >>> at a premium.
> >>
> >> No, it is NOT a "transmission flag", as it is a per-export property
> >> (where we currently have 64 bits).
> > 
> > That may be what you meant, but the patch you sent uses a flag in the
> > transmission flags field.
> > 
> > If you meant to use something else, you'll have to clarify what your
> > patch should have been like ;-)
> 
> /me goes back and re-reads spec - I shouldn't reply to mails purely off
> of memory...

Well, I tend to do that too, so no worries :-)

> Okay, I'm crossing terms here.  "Transmission flags" ARE the per-export
> flags - and are sent in response to NBD_OPT_EXPORT_NAME or NBD_OPT_INFO
> or NBD_OPT_GO.  And you are right that we only have 16 bits in the
> current spec, but that they can differ between exports (case in point:
> NBD_FLAG_READ_ONLY).  So my proposal of bit 10 as NBD_FLAG_INIT_ZEROES
> is potentially in the right place - it is a per-export property (a
> server may support multiple named exports for the client to choose from,
> of which only a subset are known to be all zero content at the time of
> export).  But your argument that 16 bits is at a premium may be worth
> considering an alternative representation for the same information.

Right.

The reason we "need" transmission flags (and I grant you that's a bit
weak of a reason) is that they get passed, unmodified, to the kernel in
case of the Linux implementation, by way of ioctl(NBD_SET_FLAGS). The
advantage to that is that we can easily teach the kernel about new
features by simply using transmission flags; if the new feature is a
boolean (i.e., either it can be used or it cannot, but the server won't
care if the client doesn't use it), then using a flag is the easiest way
to accomplish that. If it requires more (e.g., in the case of the block
sizes thing), then a flag doesn't buy us much.

When I wrote up the newstyle negotiation, I split the flags field (which
already existed, and which was already passed into the kernel in that
way) into two. Admittedly that was a mistake, but it is what it is, and
we can't extend the size of the transmission flags field except by
backwards incompatible changes. At any rate though, if the flags ever
get used up, I'm sure we could reserve flag 15 (that is, 1 << 15) as a
marker to say that there's more, and then the kernel could add another
ioctl() to add a second flags field, which the user-space client could
ask from the server by way of another NBD_OPT_* message (and it could
discover that it exists by way of NBD_OPT_INFO).

All that to say that I think a flag is really only useful if it marks
support in the server for some feature which would be backwards
incompatible if the client were to just use it without further
consideration. If that isn't the case, then some option haggling is
probably the better choice.

In case of "this device is initialized with zeroes", I'm frankly not
sure what good that information would do to the kernel; I don't think
it's anything which could allow it to optimize (or not) some things.
Perhaps at the start, yes, but as soon as it's written *something*, it'd
be useless information (unless it were to keep a bitmap of some sort,
but by that time you're optimizing for a corner case, which seems
silly). This, too, is another reason why I don't think your proposal as
stated is very useful.

> Possibility 1: when we run out of our current 16 transmission flags,
> we'll need a way to extend the protocol to support more than that.  To
> do that, we'd probably want a new Handshake flag
> NBD_FLAG_LARGE_TRANSMISSION_FLAGS sent by the server, and which must be
> answered by the client sending a new Client flag
> NBD_FLAG_C_LARGE_TRANSMISSION_FLAGS, so that both sides know that all
> subsequent places in the protocol that send transmission flags will now
> send 64 bits instead of 16 bits (old-style negotiation cannot benefit
> from this, and is permanently stuck at 16 bits, but we discourage
> old-style negotiation).

That could work too, yes.

[...]
> Possibility 2: Leverage the extension-info branch: Add a new
> NBD_INFO_INIT_ZERO information datum.

I think this is preferable, really.

[...]
> We'll probably have to eventually use something along the lines of
> possibility 1 for more transmission flags for some other reason down the
> road (since we have lately been adding one flag per new command/command
> group as we add extensions), but I agree that it is a bit heavy for now.
>  So it sounds like I should rework the proposal along the lines of
> possibility 2, which also implies that we should get extension-info
> ready for promotion to current.

Indeed.

> And that means that my current proposal to the extension-write-zeroes
> branch is probably not ideal, but it reopens the question of whether
> extension-write-zeroes as it currently stands is ready for promotion
> to stable now that qemu 2.8 implements it.

Right.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
