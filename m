Received: from eggs.gnu.org ([2001:4830:134:3::10]:59922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1friqr-0004il-Ez
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1friqn-0000ew-GE
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:00:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1friqn-0000eY-Bw
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:00:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <153458654892.28280.9192299594353632366@502c9da6d61e>
	<87y3d1sam1.fsf@dusky.pond.sub.org>
	<20180820084239.GG10682@lemon.usersys.redhat.com>
Date: Mon, 20 Aug 2018 13:59:53 +0200
In-Reply-To: <20180820084239.GG10682@lemon.usersys.redhat.com> (Fam Zheng's
	message of "Mon, 20 Aug 2018 16:42:39 +0800")
Message-ID: <871satqmdi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 00/60] json: Fixes,
 error reporting improvements, cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Fam Zheng <famz@redhat.com> writes:

> On Mon, 08/20 10:31, Markus Armbruster wrote:
>> no-reply@patchew.org writes:
>> 
>> > Hi,
>> >
>> > This series seems to have some coding style problems. See output below for
>> > more information:
>> [...]
>> > Checking PATCH 4/60: qmp-cmd-test: Split off qmp-test...
>> > WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>> > #48: 
>> > new file mode 100644
>> 
>> False positive: the patch does update MAINTAINERS.  Surprising, since
>> commit 1a6fad0c3bd "checkpatch: reduce MAINTAINERS update message
>> frequency" suppresses this.  Fam, is patchew running an outdated version
>> of checkpatch?
>
> I'm sure Patchew is using the latest checkpatch here. This is basically /me
> reproducing what it does:
>
> fam@lemon:~/work/qemu [master]$ git fetch https://github.com/patchew-project/qemu tags/patchew/20180817150559.16243-1-armbru@redhat.com
>>From https://github.com/patchew-project/qemu
>  * tag                     patchew/20180817150559.16243-1-armbru@redhat.com -> FETCH_HEAD
> fam@lemon:~/work/qemu [master]$ git checkout FETCH_HEAD
> Note: checking out 'FETCH_HEAD'.
>
> You are in 'detached HEAD' state. You can look around, make experimental
> changes and commit them, and you can discard any commits you make in this
> state without impacting any branches by performing another checkout.
>
> If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -b with the checkout command again. Example:
>
>   git checkout -b <new-branch-name>
>
> HEAD is now at 884c1e75d7 json: Support %% in JSON strings when interpolating
> fam@lemon:~/work/qemu$ git log --oneline | grep 'qmp-cmd-test: Split off qmp-test'
> b9ac2b614b qmp-cmd-test: Split off qmp-test
> fam@lemon:~/work/qemu$ git show --format=email b9ac2b614b | ./scripts/checkpatch.pl -
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #48:
> new file mode 100644
>
> total: 0 errors, 1 warnings, 460 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> fam@lemon:~/work/qemu$ git log --oneline  ./scripts/checkpatch.pl | grep 1a6fad0
> 1a6fad0c3b checkpatch: reduce MAINTAINERS update message frequency

Okay, I can reproduce the warning the way patchew runs checkpatch:

    $ git-show --format=email 4552d915d3 | ./scripts/checkpatch.pl -
    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
    #47: 
    new file mode 100644

    total: 0 errors, 1 warnings, 460 lines checked

    Your patch has style problems, please review.  If any of these errors
    are false positives report them to the maintainer, see
    CHECKPATCH in MAINTAINERS.

However:

    $ git-format-patch -1 4552d915d3
    0001-qmp-cmd-test-Split-off-qmp-test.patch
    $ ./scripts/checkpatch.pl 0001-qmp-cmd-test-Split-off-qmp-test.patch 
    total: 0 errors, 0 warnings, 460 lines checked

    0001-qmp-cmd-test-Split-off-qmp-test.patch has no obvious style problems and is ready for submission.

The difference between the two: git-show --format=email lacks diffstat.

    $ git-show --format=email 4552d915d3 | diff - 0001-qmp-cmd-test-Split-off-qmp-test.patch 
    11a12,18
    > ---
    >  MAINTAINERS            |   1 +
    >  tests/Makefile.include |   3 +
    >  tests/qmp-cmd-test.c   | 213 +++++++++++++++++++++++++++++++++++++++++
    >  tests/qmp-test.c       | 193 +------------------------------------
    >  4 files changed, 219 insertions(+), 191 deletions(-)
    >  create mode 100644 tests/qmp-cmd-test.c
    497a505,507
    > -- 
    > 2.17.1
    > 
