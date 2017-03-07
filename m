Received: from eggs.gnu.org ([2001:4830:134:3::10]:50032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clG8h-0005hP-36
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clG8a-0004dG-Uk
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:30:59 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1clG8a-0004cx-Mv
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:30:52 -0500
Received: by mail-wr0-x234.google.com with SMTP id g10so2606687wrg.2
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 06:30:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488871237-12332-1-git-send-email-armbru@redhat.com>
References: <1488871237-12332-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Mar 2017 14:30:30 +0000
Message-ID: <CAFEAcA-SBSz5M_GDEQhqvb+=5WprkwURKb_sY2M9VewJJ+N1Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 March 2017 at 07:20, Markus Armbruster <armbru@redhat.com> wrote:
> Actually, the command line option is the least part of this series.
> Its bulk is about building infrastructure and getting errors out of
> the JSON parser.
>
> The design of the command line interface was discussed here:
> Subject: Non-flat command line option argument syntax
> Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html
>
> v3: A few commit messages touched up, code unchanged
>
> The following changes since commit fbddc2e5608eb655493253d080598375db61a748:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-02-28' into staging (2017-03-06 10:18:33 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-block-2017-02-28-v3
>
> for you to fetch changes up to de479f01438d974100ac9ec10ab82c2ee1ad124f:
>
>   keyval: Support lists (2017-03-07 08:15:18 +0100)

The clang sanitizer has a complaint about your new test:

  GTESTER tests/test-keyval
/home/petmay01/linaro/qemu-for-merges/util/keyval.c:129:15: runtime
error: member access within null pointer of type 'QString' (aka
'struct QString')

which is the line:
        new = QOBJECT(value) ?: QOBJECT(qdict_new());

This is because QOBJECT is defined as:

#define QOBJECT(obj) (&(obj)->base)

and so it doesn't have the "if you pass in NULL you get NULL"
semantics that OBJECT() and all the QOM object typecast
macros do.

(As an aside, it's rather confusing to have a QObject
whose header claims it's part of the "QEMU Object Model"
which is completely different from the QOM Object...)

thanks
-- PMM
