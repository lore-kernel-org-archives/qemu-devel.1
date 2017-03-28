Received: from eggs.gnu.org ([2001:4830:134:3::10]:46335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csv2Y-0004Wh-Ue
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csv2X-00014u-De
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:36:18 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csv2X-00014f-55
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:36:17 -0400
Received: by mail-wm0-x234.google.com with SMTP id t189so4899341wmt.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 10:36:17 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 18:35:55 +0100
Message-ID: <CAFEAcA_Dwky8Jr+y3JACdK5MVM82syrvzuVktnJF0cyZ-FjY0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] qemu-devel mailing list vs DMARC and microsoft.com's
 p=reject policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Hi; it's been pointed out to me that we have a problem with qemu-devel
unsubscribing people because of DMARC. Specifically:
 * microsoft.com publishes a DMARC policy that has p=reject
 * some subscribers use mail systems that honour this and send bounces
   for non-verifying emails from those domains
 * the mailing list software (mailman) modifies emails that pass through
   it, among other things adding the "[qemu-devel]" subject tag, in
   a way that means that signatures no longer verify
 * bounces back to mailman as a result of mailing list postings from
   microsoft.com people can then cause people to be unintentionally
   unsubscribed

This is kind of painful. https://wiki.list.org/DEV/DMARC has the
Mailman wiki information on the subject. In an ideal world nobody
would use p=reject because it breaks mailing lists. In the actual
world we have a few choices:

 (1) I could set dmarc_moderation_action=Reject
   * this means nobody can subscribe if they've set their dmarc policy
     to reject (the "if you don't believe in mailing lists we don't
     believe in you" policy).
   * there is a certain purity to this option, in that it is pushing
     the costs of this unhelpful mail config back on the organisations
     which have chosen it; on the other hand I'm reluctant to make
     life harder for people who are contributing to the project
     and who typically don't have much say over corporate email config.
 (2) I could reconfigure mailman to try to not rewrite anything that
     we think is likely to be signed (in particular not the body or the
     subject)
   * this means dropping the [qemu-devel] tag from the subject, which I'm
     a bit reluctant to do (it seems likely at least some readers are
     filtering on it, and personally I quite like it)
   * if anybody DKIM-signs the Sender: header we're stuck anyway
 (3) I could set dmarc_moderation_action to Munge From, which means that
     those senders who have a p=reject policy will get their mails
     rewritten to have a From="Whoever (via the list) <qemu-devel@...>"
     and their actual email in the Reply-to:
   * if anybody's mail client doesn't honour Reply-to: then what they
     think is a personal reply will go to the list by accident
 (4) I could do nothing, and hope that we don't get so many of these
     that they actually result in unsubscriptions
   * in any case emails won't end up going through to some recipients,
     so this isn't much of an option anyway
 (5) I could set the bounce processing config to be (much) less aggressive
   * this seems like a bad idea
   * in any case people whose systems honour DMARC still wouldn't get
     mails from the p=reject senders

I don't really like any of these choices.

For the moment I have picked option (3), but I'm open to argument
that we should pick something else.

thanks
-- PMM
