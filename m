Received: from eggs.gnu.org ([2001:4830:134:3::10]:60130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf2KX-0005IU-Uv
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf2KW-0002TV-Uv
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:33:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-23-git-send-email-armbru@redhat.com>
	<e0e003dd-32d8-7ca2-813f-bd69a6eae9e2@redhat.com>
Date: Sat, 18 Feb 2017 11:33:21 +0100
In-Reply-To: <e0e003dd-32d8-7ca2-813f-bd69a6eae9e2@redhat.com> (Eric Blake's
	message of "Fri, 17 Feb 2017 16:03:44 -0600")
Message-ID: <87o9xz6b66.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 22/24] util/cutils: Return qemu_strtosz*()
 error and value separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 02/14/2017 04:26 AM, Markus Armbruster wrote:
>> This makes qemu_strtosz(), qemu_strtosz_mebi() and
>> qemu_strtosz_metric() similar to qemu_strtoi64(), except negative
>> values are rejected.
>
> Yay. It also opens the door to allowing them to return an unsigned 64
> bit value ;)
>
>> 
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
>> Cc: Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
>> Cc: Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
>> Cc: qemu-block@nongnu.org (open list:Block layer core)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> @@ -1378,8 +1378,8 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>                  break;
>>              case MIGRATION_PARAMETER_MAX_BANDWIDTH:
>>                  p.has_max_bandwidth = true;
>> -                valuebw = qemu_strtosz_mebi(valuestr, NULL);
>> -                if (valuebw < 0 || (size_t)valuebw != valuebw) {
>> +                ret = qemu_strtosz_mebi(valuestr, NULL, &valuebw);
>> +                if (ret < 0 || (size_t)valuebw != valuebw) {
>
> Question: do we want a wrapper that takes a maximum, as in:
>
> ret = qemu_strtosz_capped(valuestr, NULL, 'M', SIZE_MAX, &valuebw);
>
> so that the caller doesn't have to check (size_t)valuebw != valuebw ?

Maybe.

It's a more interesting question for qemu_strtou64(), actually.  The
obvious

    err = qemu_strtou64(str, NULL, 0, &value);
    if (value > limit) {
        err = -ERANGE;
    }

is subtly weird.  With str = "-1", you get value = UINT64_MAX.  With str
= "-18446744073709551615", you get value = 1.  Rejecting the former but
accepting the latter is weird.

> But not essential, so I can live with what you did here.
>
>
>> +++ b/qemu-img.c
>> @@ -370,10 +370,14 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
>>  
>>  static int64_t cvtnum(const char *s)
>
>> +++ b/qemu-io-cmds.c
>> @@ -137,10 +137,14 @@ static char **breakline(char *input, int *count)
>>  
>>  static int64_t cvtnum(const char *s)
>
> May be some fallout based on rebase churn from earlier patch reviews,
> but nothing too serious to prevent you from adding:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
