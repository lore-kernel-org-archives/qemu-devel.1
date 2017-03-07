Received: from eggs.gnu.org ([2001:4830:134:3::10]:59243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clGgg-0007qq-S2
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clGgb-0006xb-1V
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:06:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1clGga-0006xF-Ri
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:06:00 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488871237-12332-1-git-send-email-armbru@redhat.com>
	<CAFEAcA-SBSz5M_GDEQhqvb+=5WprkwURKb_sY2M9VewJJ+N1Zw@mail.gmail.com>
Date: Tue, 07 Mar 2017 16:05:58 +0100
In-Reply-To: <CAFEAcA-SBSz5M_GDEQhqvb+=5WprkwURKb_sY2M9VewJJ+N1Zw@mail.gmail.com>
	(Peter Maydell's message of "Tue, 7 Mar 2017 14:30:30 +0000")
Message-ID: <87efy99lex.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL v3 00/24] block: Command line option
 -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 7 March 2017 at 07:20, Markus Armbruster <armbru@redhat.com> wrote:
>> Actually, the command line option is the least part of this series.
>> Its bulk is about building infrastructure and getting errors out of
>> the JSON parser.
>>
>> The design of the command line interface was discussed here:
>> Subject: Non-flat command line option argument syntax
>> Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html
>>
>> v3: A few commit messages touched up, code unchanged
>>
>> The following changes since commit fbddc2e5608eb655493253d080598375db61a748:
>>
>>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-02-28' into staging (2017-03-06 10:18:33 +0000)
>>
>> are available in the git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-block-2017-02-28-v3
>>
>> for you to fetch changes up to de479f01438d974100ac9ec10ab82c2ee1ad124f:
>>
>>   keyval: Support lists (2017-03-07 08:15:18 +0100)
>
> The clang sanitizer has a complaint about your new test:
>
>   GTESTER tests/test-keyval
> /home/petmay01/linaro/qemu-for-merges/util/keyval.c:129:15: runtime
> error: member access within null pointer of type 'QString' (aka
> 'struct QString')
>
> which is the line:
>         new = QOBJECT(value) ?: QOBJECT(qdict_new());
>
> This is because QOBJECT is defined as:
>
> #define QOBJECT(obj) (&(obj)->base)
>
> and so it doesn't have the "if you pass in NULL you get NULL"
> semantics that OBJECT() and all the QOM object typecast
> macros do.

QOBJECT() returns its argument, so this is rather pedantic.  However,
placating the sanitize isn't too onerous; this should do:

        new = value ? QOBJECT(value) : QOBJECT(qdict_new());

> (As an aside, it's rather confusing to have a QObject
> whose header claims it's part of the "QEMU Object Model"
> which is completely different from the QOM Object...)

Hey, QObject claimed the name first!

Seriously, I hate the name clash, too.  Rewording the comment is easy
enough.  Even better would be renaming QObject, but that's a lot of
churn.
