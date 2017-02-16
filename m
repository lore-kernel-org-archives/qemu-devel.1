Received: from eggs.gnu.org ([2001:4830:134:3::10]:54043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ceLdk-00005v-Ts
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ceLdh-0002Aw-1b
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:58:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ceLdg-0002Ap-S2
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:58:24 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D09C83F44
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 12:58:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-3-git-send-email-armbru@redhat.com>
	<99dd0998-5e15-888f-301c-141c931b10a8@redhat.com>
Date: Thu, 16 Feb 2017 13:58:21 +0100
In-Reply-To: <99dd0998-5e15-888f-301c-141c931b10a8@redhat.com> (Eric Blake's
	message of "Tue, 14 Feb 2017 14:10:17 -0600")
Message-ID: <87shnegumq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/24] QemuOpts: Assert value string isn't
 null
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

> On 02/14/2017 04:25 AM, Markus Armbruster wrote:
>> Plenty of code relies on QemuOpt member @str not being null, including
>> qemu_opts_print(), qemu_opts_to_qdict(), and callbacks passed to
>> qemu_opt_foreach().
>> 
>
>> 
>> Assert member @str isn't null, so that misuse is caught right away.
>> 
>> Simplify parse_option_bool(), parse_option_number() and
>> parse_option_size() accordingly.  Best viewed with whitespace changes
>> ignored.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  util/qemu-option.c | 89 ++++++++++++++++++++++++------------------------------
>>  1 file changed, 39 insertions(+), 50 deletions(-)
>> 
>
>> @@ -180,39 +172,35 @@ void parse_option_size(const char *name, const char *value,
>>      char *postfix;
>>      double sizef;
>>  
>
>> +    sizef = strtod(value, &postfix);
>> +    if (sizef < 0 || sizef > UINT64_MAX) {
>> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
>> +                   "a non-negative number below 2^64");
>> +        return;
>> +    }
>> +    switch (*postfix) {
>> +    case 'T':
> ...
>> +    default:
>>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name, "a size");
>> +        error_append_hint(errp, "You may use k, M, G or T suffixes for "
>> +                          "kilobytes, megabytes, gigabytes and terabytes.\n");
>> +        return;
>>      }
>
> Unrelated to this patch, but noticing it now: it looks like we blindly
> accept "qemu-system-x86_64 -nodefaults -m 1Mgarbage" as meaning the same
> as "... -m 1M".  Looking back at 1/24, looks like you marked that as one
> of the buggy cases.

Correct.

>                      Good - I guess I'll get to comment more on it in a
> later patch.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
