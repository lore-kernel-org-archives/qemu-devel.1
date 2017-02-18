Received: from eggs.gnu.org ([2001:4830:134:3::10]:57050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf21W-000867-Fn
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf21V-0004a0-IP
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:13:50 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-21-git-send-email-armbru@redhat.com>
	<b51fa4ed-874d-673f-e2e4-1cf24cd251f6@redhat.com>
Date: Sat, 18 Feb 2017 11:13:40 +0100
In-Reply-To: <b51fa4ed-874d-673f-e2e4-1cf24cd251f6@redhat.com> (Eric Blake's
	message of "Fri, 17 Feb 2017 15:10:55 -0600")
Message-ID: <87y3x36c2z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 20/24] qemu-img: Wrap cvtnum() around
 qemu_strtosz()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 02/14/2017 04:26 AM, Markus Armbruster wrote:
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: qemu-block@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qemu-img.c | 58 +++++++++++++++++++++++++++++++---------------------------
>>  1 file changed, 31 insertions(+), 27 deletions(-)
>
>
>> @@ -3858,11 +3866,9 @@ static int img_dd_count(const char *arg,
>>                          struct DdIo *in, struct DdIo *out,
>>                          struct DdInfo *dd)
>>  {
>> -    char *end;
>> +    dd->count = cvtnum(arg);
>
> Hmm. cvtnum() accepts "1.5G", GNU dd does not. POSIX requires dd to
> accept '1kx10k' to mean 10 mebibytes, and GNU dd accepts '10xM' as a
> synonym, but cvtnum() does not accept all those corner cases.  POSIX
> requires dd to treat '1b' as '512', while cvdnum() treats it as '1'.  I
> sometimes wonder if our 'qemu-img dd' subcommand should be reusing the
> numeric parsing that we use everywhere else, in spite of it meaning that
> we are different than the POSIX quirks on what numbers are required to
> be supported by dd.

qemu-img dd falls short of its stated goal to be like /usr/bin/dd.
Whether that's good or bad I decline to judge ;)

>                      But that's not the concern of this patch.

Yes.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
