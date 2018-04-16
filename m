Received: from eggs.gnu.org ([2001:4830:134:3::10]:44315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f84pT-0004Vi-9A
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f84pP-0000Pk-BM
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:09:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43958 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f84pP-0000P8-5h
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:09:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180312131806.23209-1-stefanha@redhat.com>
	<43378184-a291-263f-b8b2-dedc455622e3@redhat.com>
Date: Mon, 16 Apr 2018 16:09:53 +0200
In-Reply-To: <43378184-a291-263f-b8b2-dedc455622e3@redhat.com> (Thomas Huth's
	message of "Mon, 12 Mar 2018 14:46:20 +0100")
Message-ID: <87604rp7im.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn about missing MAINTAINERS
 file changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Thomas Huth <thuth@redhat.com> writes:

> On 12.03.2018 14:18, Stefan Hajnoczi wrote:
>> Warn if files are added/renamed/deleted without MAINTAINERS file
>> changes.  This has helped me in Linux and we could benefit from this
>> check in QEMU.
>> 
>> This patch is a manual cherry-pick of Linux commit
>> 13f1937ef33950b1112049972249e6191b82e6c9 ("checkpatch: emit a warning on
>> file add/move/delete") by Joe Perches <joe@perches.com>.
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

We should really keep upstream's S-o-b intact.  I'd keep the whole
commit message intact:

    From 7fb819c27bf47041a13feed93f86a15bdb2c681f Mon Sep 17 00:00:00 2001
    From: Joe Perches <joe@perches.com>
    Date: Wed, 6 Aug 2014 16:10:59 -0700
    Subject: [PATCH] checkpatch: emit a warning on file add/move/delete

    Whenever files are added, moved, or deleted, the MAINTAINERS file
    patterns can be out of sync or outdated.

    To try to keep MAINTAINERS more up-to-date, add a one-time warning
    whenever a patch does any of those.

    Signed-off-by: Joe Perches <joe@perches.com>
    Acked-by: Andy Whitcroft <apw@canonical.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
    [Cherry picked from Linux commit 13f1937ef33950b1112049972249e6191b82e6c9]
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Created by running "git-format-patch -1 13f1937ef33" in the kernel,
feeding that to git-am (patch doesn't apply), patch -p1 your patch,
git-am --continue, git-commit --amend to add a backporting note and your
S-o-b.

>> ---
>> Note the 80-char lines are from upstream code.  Keep them as-is.
>> 
>>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index d1fe79bcc4..d0d8f63d48 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1177,6 +1177,7 @@ sub process {
>>  	our $clean = 1;
>>  	my $signoff = 0;
>>  	my $is_patch = 0;
>> +	my $reported_maintainer_file = 0;
>>  
>>  	our @report = ();
>>  	our $cnt_lines = 0;
>> @@ -1379,6 +1380,24 @@ sub process {
>>  			}
>>  		}
>>  
>> +# Check if MAINTAINERS is being updated.  If so, there's probably no need to
>> +# emit the "does MAINTAINERS need updating?" message on file add/move/delete
>> +		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
>> +			$reported_maintainer_file = 1;
>> +		}
>> +
>> +# Check for added, moved or deleted files
>> +		if (!$reported_maintainer_file &&
>> +		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
>> +		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
>> +		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
>> +		      (defined($1) || defined($2))))) {
>> +			$is_patch = 1;
>> +			$reported_maintainer_file = 1;
>> +			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" .
>> +				$herecurr);
>
> Could you please turn this into a notification instead of a warning? For
> rationale, please see the discussion of this patch last year:
>
> http://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05753.html

Quoting that one:

    I think chances are high that it still pops up quite frequently with
    false positives:

    1) The above regex only triggers for patches that contain a diffstat. If
    you run the script on patches without diffstat, you always get the
    warning as soon as you add, delete or move a file, even if you update
    the MAINTAINERS file in the same patch.

"Doctor, it hurts when I create patches without a diffstat."

    2) I think it is quite common in patch series to first introduce new
    files in the first patches, and then update MAINTAINERS only once at the
    end.

That's an okay thing to do now.  But is it a valid reason to block
tooling improvements that will help us stop the constant trickle of new
files without a maintainer?  Having to update MAINTAINERS along the way
isn't *that* much of a burden; we'll get used to it.

    3) The MAINTAINERS file often covers whole folders with wildcard
    expressions. So if you add/delete/rename a file within such a folder,
    you don't need to update MAINTAINERS thanks to the wildcard.

True.  Perhaps the kernel would appreciate a suitable checkpatch.pl
improvement.

    I guess people might be annoyed if checkpatch.pl throws a warning in
    these cases. So a "NOTE: ..." sounds more sane to me. But if you like,
    we can also start with a WARNING first and only ease it if people start
    to complain?

I'd stick to the upstream version.  But if it takes deviations to get
this improvement accepted, I can live with them, as long as patchew
still flags offenders.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
