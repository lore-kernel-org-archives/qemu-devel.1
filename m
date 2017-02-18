Received: from eggs.gnu.org ([2001:4830:134:3::10]:33005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf2RX-0007bR-A7
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf2RW-0005Xr-D4
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:40:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-24-git-send-email-armbru@redhat.com>
	<711102c9-cd43-6c6f-cf2e-422251bbb211@redhat.com>
Date: Sat, 18 Feb 2017 11:40:33 +0100
In-Reply-To: <711102c9-cd43-6c6f-cf2e-422251bbb211@redhat.com> (Eric Blake's
	message of "Fri, 17 Feb 2017 16:19:58 -0600")
Message-ID: <87k28n6au6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 23/24] util/cutils: Change qemu_strtosz*()
 from int64_t to uint64_t
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
>> This will permit its use in parse_option_size().
>
> Progress!  (not that it matters - off_t is a signed value, so you are
> STILL limited to 2^63, not 2^64, as the maximum theoretical size storage
> that you can target - and it's not like we have that much storage even
> accessible)
>
>> 
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
>> Cc: Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
>> Cc: Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
>> Cc: qemu-block@nongnu.org (open list:Block layer core)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/hmp.c
>> @@ -1338,7 +1338,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>  {
>>      const char *param = qdict_get_str(qdict, "parameter");
>>      const char *valuestr = qdict_get_str(qdict, "value");
>> -    int64_t valuebw = 0;
>> +    uint64_t valuebw = 0;
>>      long valueint = 0;
>>      Error *err = NULL;
>>      bool use_int_value = false;
>> @@ -1379,7 +1379,8 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>              case MIGRATION_PARAMETER_MAX_BANDWIDTH:
>>                  p.has_max_bandwidth = true;
>>                  ret = qemu_strtosz_mebi(valuestr, NULL, &valuebw);
>> -                if (ret < 0 || (size_t)valuebw != valuebw) {
>> +                if (ret < 0 || valuebw > INT64_MAX
>> +                    || (size_t)valuebw != valuebw) {
>
> I don't know if this looks any better as:
>
> if (ret < 0 || valuebw > MIN(INT64_MAX, SIZE_MAX))
>
> so don't bother changing it if you think that's ugly.

I think (size_t)valuebw != valuebw neatly expresses "valuebw not
representable as size_t".  Requires unsigned, though.

>> +++ b/qapi/opts-visitor.c
>> @@ -481,7 +481,6 @@ opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
>>  {
>>      OptsVisitor *ov = to_ov(v);
>>      const QemuOpt *opt;
>> -    int64_t val;
>>      int err;
>>  
>>      opt = lookup_scalar(ov, name, errp);
>> @@ -489,14 +488,13 @@ opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
>>          return;
>>      }
>>  
>> -    err = qemu_strtosz(opt->str ? opt->str : "", NULL, &val);
>> +    err = qemu_strtosz(opt->str ? opt->str : "", NULL, obj);
>>      if (err < 0) {
>>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
>> -                   "a size value representible as a non-negative int64");
>
> Nice - you're killing the unusual variant spelling of representable.
>
>> +++ b/util/cutils.c
>> @@ -207,7 +207,7 @@ static int64_t suffix_mul(char suffix, int64_t unit)
>>   */
>>  static int do_strtosz(const char *nptr, char **end,
>>                        const char default_suffix, int64_t unit,
>> -                      int64_t *result)
>> +                      uint64_t *result)
>>  {
>>      int retval;
>>      char *endptr;
>> @@ -237,7 +237,11 @@ static int do_strtosz(const char *nptr, char **end,
>>          retval = -EINVAL;
>>          goto out;
>>      }
>> -    if ((val * mul >= INT64_MAX) || val < 0) {
>> +    /*
>> +     * Values >= 0xfffffffffffffc00 overflow uint64_t after their trip
>> +     * through double (53 bits of precision).
>> +     */
>> +    if ((val * mul >= 0xfffffffffffffc00) || val < 0) {
>
> I guess there's not any simpler expression using INT64_MAX and
> operations (including casts to double and int64_t) that would reliably
> produce the same constant that you just open-coded here.

I think the literal plus the comment explaining it is easier to read.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
