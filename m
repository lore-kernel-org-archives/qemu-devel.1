Received: from eggs.gnu.org ([2001:4830:134:3::10]:59304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg6h8-00027V-RM
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:25:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg6h7-00023N-RP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:25:14 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-24-git-send-email-armbru@redhat.com>
	<20170220201647.GL2372@work-vm>
Date: Tue, 21 Feb 2017 10:25:05 +0100
In-Reply-To: <20170220201647.GL2372@work-vm> (David Alan Gilbert's message of
	"Mon, 20 Feb 2017 20:16:48 +0000")
Message-ID: <874lznnbf2.fsf@dusky.pond.sub.org>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, "open list:Block layer core" <qemu-block@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> This will permit its use in parse_option_size().
>> 
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
>> Cc: Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
>> Cc: Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
>> Cc: qemu-block@nongnu.org (open list:Block layer core)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hmp.c                 |  5 +++--
>>  hw/misc/ivshmem.c     |  2 +-
>>  include/qemu/cutils.h |  6 +++---
>>  monitor.c             |  4 ++--
>>  qapi/opts-visitor.c   |  6 ++----
>>  qemu-img.c            |  5 ++++-
>>  qemu-io-cmds.c        |  5 ++++-
>>  target/i386/cpu.c     |  4 ++--
>>  tests/test-cutils.c   | 40 ++++++++++++++++++++--------------------
>>  util/cutils.c         | 14 +++++++++-----
>>  10 files changed, 50 insertions(+), 41 deletions(-)
>> 
>> diff --git a/hmp.c b/hmp.c
>> index 9846fa4..5b9e461 100644
>> --- a/hmp.c
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
> We should probably just turn all of the parameters into size_t's - although that's
> more work and there's some int64_t's in qemu_file for no good reason.

I guess that's a comment on migration parameters, not on the strosz
family of functions.

>>                      error_setg(&err, "Invalid size %s", valuestr);
>>                      goto cleanup;
>>                  }
[...]
>> diff --git a/util/cutils.c b/util/cutils.c
>> index 08effe6..888c0fd 100644
>> --- a/util/cutils.c
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
> It would be great to get rid of the double's at some point.

Maybe.

53 bits of precision are fine in practice, if a bit awkward to document
and test once you bother to document and test (read: only now, 6 years
four months after its creation).  long double would give us 64 bits at
least on common hosts, but would be even more bothersome to document and
test.

Could try to parse both as integer and as floating-point and see which
one accepts more characters.

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

[...]
