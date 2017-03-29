Received: from eggs.gnu.org ([2001:4830:134:3::10]:45278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ct7NS-0004tg-Dw
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 02:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ct7NN-0001rl-Kf
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 02:46:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ct7NN-0001r8-C8
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 02:46:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <CAFEAcA_Dwky8Jr+y3JACdK5MVM82syrvzuVktnJF0cyZ-FjY0A@mail.gmail.com>
	<20170328210014-mutt-send-email-mst@kernel.org>
Date: Wed, 29 Mar 2017 08:46:27 +0200
In-Reply-To: <20170328210014-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Tue, 28 Mar 2017 21:28:06 +0300")
Message-ID: <8737dwr35o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Mar 28, 2017 at 06:35:55PM +0100, Peter Maydell wrote:
>> Hi; it's been pointed out to me that we have a problem with qemu-devel
>> unsubscribing people because of DMARC. Specifically:
>>  * microsoft.com publishes a DMARC policy that has p=reject
>>  * some subscribers use mail systems that honour this and send bounces
>>    for non-verifying emails from those domains
>>  * the mailing list software (mailman) modifies emails that pass through
>>    it, among other things adding the "[qemu-devel]" subject tag, in
>>    a way that means that signatures no longer verify
>>  * bounces back to mailman as a result of mailing list postings from
>>    microsoft.com people can then cause people to be unintentionally
>>    unsubscribed
>> 
>> This is kind of painful. https://wiki.list.org/DEV/DMARC has the
>> Mailman wiki information on the subject. In an ideal world nobody
>> would use p=reject because it breaks mailing lists. In the actual
>> world we have a few choices:
>> 
>>  (1) I could set dmarc_moderation_action=Reject
>>    * this means nobody can subscribe if they've set their dmarc policy
>>      to reject (the "if you don't believe in mailing lists we don't
>>      believe in you" policy).
>>    * there is a certain purity to this option, in that it is pushing
>>      the costs of this unhelpful mail config back on the organisations
>>      which have chosen it; on the other hand I'm reluctant to make
>>      life harder for people who are contributing to the project
>>      and who typically don't have much say over corporate email config.
>>  (2) I could reconfigure mailman to try to not rewrite anything that
>>      we think is likely to be signed (in particular not the body or the
>>      subject)
>>    * this means dropping the [qemu-devel] tag from the subject, which I'm
>>      a bit reluctant to do (it seems likely at least some readers are
>>      filtering on it, and personally I quite like it)
>>    * if anybody DKIM-signs the Sender: header we're stuck anyway
>
> For the record I'd strongly prefer this option - I tag all list mail
> and so "qemu-devel" appears twice: in subject and as a tag.
> Also, if mail is copied to another list, qemu-devel will
> still appear as gmail de-duplicates email by msg id.
> I can remove tags I don't care about but can't remove
> subject prefixes.

Seconded.  Mailing lists messing with the subject to "help" users with
filtering just complicate it.

Filtering on List-Id isn't any harder, and has the added advantage that
it actually works.

>>  (3) I could set dmarc_moderation_action to Munge From, which means that
>>      those senders who have a p=reject policy will get their mails
>>      rewritten to have a From="Whoever (via the list) <qemu-devel@...>"
>>      and their actual email in the Reply-to:
>>    * if anybody's mail client doesn't honour Reply-to: then what they
>>      think is a personal reply will go to the list by accident
>>  (4) I could do nothing, and hope that we don't get so many of these
>>      that they actually result in unsubscriptions
>>    * in any case emails won't end up going through to some recipients,
>>      so this isn't much of an option anyway
>>  (5) I could set the bounce processing config to be (much) less aggressive
>>    * this seems like a bad idea
>>    * in any case people whose systems honour DMARC still wouldn't get
>>      mails from the p=reject senders
>> 
>> I don't really like any of these choices.
>> 
>> For the moment I have picked option (3), but I'm open to argument
>> that we should pick something else.
>> 
>> thanks
>> -- PMM
>
> Is there a way not to munge the name? It's currently rewritten to
> add "via qemu-devel" which confuses the clients which think
> it's part of the name, and can't be easily stripped away.

Not munging the name will confuse different clients to think qemu-devel@
is an alternative e-mail for this person.

Once you start messing with e-mail headers, you inevitably get to a
place where you have to choose the functionality you're least unhappy to
break.  Which may not be the one your users are least happy to lose.

Just say no.
