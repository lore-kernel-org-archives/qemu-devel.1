Received: from eggs.gnu.org ([2001:4830:134:3::10]:51403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctDx0-0004j4-IZ
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctDww-0006eL-4C
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:47:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ctDwv-0006e6-RT
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:47:46 -0400
Date: Wed, 29 Mar 2017 16:47:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170329161852-mutt-send-email-mst@kernel.org>
References: <CAFEAcA_Dwky8Jr+y3JACdK5MVM82syrvzuVktnJF0cyZ-FjY0A@mail.gmail.com>
	<20170328210014-mutt-send-email-mst@kernel.org>
	<8737dwr35o.fsf@dusky.pond.sub.org>
	<862ea872-423a-8394-3ed5-250b0a3d2ba2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <862ea872-423a-8394-3ed5-250b0a3d2ba2@redhat.com>
Subject: Re: [Qemu-devel] qemu-devel mailing list vs DMARC and
 microsoft.com's p=reject policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Mar 29, 2017 at 12:44:27PM +0200, Thomas Huth wrote:
> On 29.03.2017 08:46, Markus Armbruster wrote:
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > 
> >> On Tue, Mar 28, 2017 at 06:35:55PM +0100, Peter Maydell wrote:
> >>> Hi; it's been pointed out to me that we have a problem with qemu-devel
> >>> unsubscribing people because of DMARC. Specifically:
> >>>  * microsoft.com publishes a DMARC policy that has p=reject
> >>>  * some subscribers use mail systems that honour this and send bounces
> >>>    for non-verifying emails from those domains
> >>>  * the mailing list software (mailman) modifies emails that pass through
> >>>    it, among other things adding the "[qemu-devel]" subject tag, in
> >>>    a way that means that signatures no longer verify
> >>>  * bounces back to mailman as a result of mailing list postings from
> >>>    microsoft.com people can then cause people to be unintentionally
> >>>    unsubscribed
> >>>
> >>> This is kind of painful. https://wiki.list.org/DEV/DMARC has the
> >>> Mailman wiki information on the subject. In an ideal world nobody
> >>> would use p=reject because it breaks mailing lists. In the actual
> >>> world we have a few choices:
> >>>
> >>>  (1) I could set dmarc_moderation_action=Reject
> >>>    * this means nobody can subscribe if they've set their dmarc policy
> >>>      to reject (the "if you don't believe in mailing lists we don't
> >>>      believe in you" policy).
> >>>    * there is a certain purity to this option, in that it is pushing
> >>>      the costs of this unhelpful mail config back on the organisations
> >>>      which have chosen it; on the other hand I'm reluctant to make
> >>>      life harder for people who are contributing to the project
> >>>      and who typically don't have much say over corporate email config.
> >>>  (2) I could reconfigure mailman to try to not rewrite anything that
> >>>      we think is likely to be signed (in particular not the body or the
> >>>      subject)
> >>>    * this means dropping the [qemu-devel] tag from the subject, which I'm
> >>>      a bit reluctant to do (it seems likely at least some readers are
> >>>      filtering on it, and personally I quite like it)
> >>>    * if anybody DKIM-signs the Sender: header we're stuck anyway
> >>
> >> For the record I'd strongly prefer this option - I tag all list mail
> >> and so "qemu-devel" appears twice: in subject and as a tag.
> >> Also, if mail is copied to another list, qemu-devel will
> >> still appear as gmail de-duplicates email by msg id.
> >> I can remove tags I don't care about but can't remove
> >> subject prefixes.
> > 
> > Seconded.  Mailing lists messing with the subject to "help" users with
> > filtering just complicate it.
> > 
> > Filtering on List-Id isn't any harder, and has the added advantage that
> > it actually works.
> 
> The problem is that some mail clients are rather limited and you can
> only filter via title there - so I guess some people would complain we
> removed the tag from the subject.

Do you mean gmail by any chance? In gmail you can filter using list:
which isn't well known. This works even if you get same mail through
multiple paths. filtering by subject in gmail is extermely unreliable:
if you get a copy directly it discards others and so you get
an inconsistent mix of messages with and without the subject prefix.

In short I suspect filtering by subject works only half-way and
most people just don't notice.

> Apart from that, I've also seen mailman messing up white spaces in the
> body of e-mails, so this likely would only solve parts of this problem.
> 
>  Thomas
