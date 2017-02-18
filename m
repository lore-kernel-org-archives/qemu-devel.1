Received: from eggs.gnu.org ([2001:4830:134:3::10]:34521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf2X7-0001ak-Sk
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf2X3-00080q-14
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:46:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cf2X2-00080g-RM
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:46:24 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 884323B755
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 10:46:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-25-git-send-email-armbru@redhat.com>
	<5ade6214-3ec8-162c-55aa-e71f44a99009@redhat.com>
Date: Sat, 18 Feb 2017 11:46:21 +0100
In-Reply-To: <5ade6214-3ec8-162c-55aa-e71f44a99009@redhat.com> (Eric Blake's
	message of "Fri, 17 Feb 2017 16:27:51 -0600")
Message-ID: <87efyv6aki.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 24/24] QemuOpts: Fix checking of sizes for
 overflow and trailing crap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/14/2017 04:26 AM, Markus Armbruster wrote:
>> parse_option_size()'s checking for overflow and trailing crap is
>> wrong.  Has always been that way.  qemu_strtosz() gets it right, so
>> use that.
>> 
>> This adds support for size suffixes 'P', 'E', and ignores case for all
>> suffixes, not just 'k'.
>
> Yay! Be liberal in what you accept!  (I've always been annoyed that '-m
> 1g' complains, forcing me to us '-m 1G').

The liberality is okay when we measure bytes, because 'm' can only mean
"mega" there.  It's problematic when we measure things like seconds,
where 'm' definitely should mean "milli".

Perhaps I should make do_strtosz() case-insensitive only when unit ==
1024, but not when unit == 1000.

> Okay, we're at the end of the series, and I've pointed out other
> possible improvements.  As mentioned elsewhere, it might be nice to add
> a 25/24 to match coreutils, which allows 'm' and 'mib' to mean
> 1024*1024, vs. 'mb' to mean 1000*1000.  Right now, all clients of
> qemu_strtosz() are stuck to one scale, vs. letting the user choose a
> scale by their choice of suffix.  But it does not hold up this series if
> you don't like the idea.

I'd prefer not to do that now, because I'm busy on getting -blockdev
done before the soft freeze.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/test-qemu-opts.c | 21 +++++++++------------
>>  util/qemu-option.c     | 41 +++++++++++++----------------------------
>>  2 files changed, 22 insertions(+), 40 deletions(-)
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
