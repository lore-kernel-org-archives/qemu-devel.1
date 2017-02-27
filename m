Received: from eggs.gnu.org ([2001:4830:134:3::10]:51292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciRHr-0001Ym-KT
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciRHq-0000FV-M1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:48:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciRHq-0000F8-Dk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:48:46 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 863A98123F
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 19:48:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170118135624.17368-1-ehabkost@redhat.com>
	<20170118135624.17368-2-ehabkost@redhat.com>
	<87bmtna50o.fsf@dusky.pond.sub.org>
	<20170227190500.GE2778@thinpad.lan.raisama.net>
Date: Mon, 27 Feb 2017 20:48:43 +0100
In-Reply-To: <20170227190500.GE2778@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Mon, 27 Feb 2017 16:05:00 -0300")
Message-ID: <87bmtn5s9w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] config: qemu_config_parse() return
 number of config groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Feb 27, 2017 at 06:59:51PM +0100, Markus Armbruster wrote:
>> Uh, I totally forgot about this series.  My apologies...
>> 
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > Change qemu_config_parse() to return the number of config groups
>> > in success and -EINVAL on error. This will allow callers of
>> > qemu_config_parse() to check if something was really loaded from
>> > the config file.
>> >
>> > All existing callers of qemu_config_parse() and
>> > qemu_read_config_file() only check if the return value was
>> > negative, so the change shouldn't affect them.
>> 
>> Two of them:
>> 
>> * read_config() maps negative value to -EINVAL.  Callers:
>> 
>>   - blkdebug_open() passes it on.  As a .bdrv_file_open() method, it's
>>     supposed to return -errno on failure.  Good.
>> 
>> * qemu_read_config_file() maps non-zero value to -EINVAL.  Callers:
>> 
>>   - qemu_read_default_config_file() maps -EINVAL to zero.  WTF?
>
> qemu_read_config_file() maps -ENOENT to zero, not -EINVAL. It
> will ignore the error only if the default config file doesn't
> exist (if fopen() sets errno to ENOENT).

Crosseyed reviewer syndrome...

>>   - main() passes sterror(EINVAL) to error_report().  Good.
>> 
>> Also: qemu_config_parse() reports errors with error_report().  Let's
>> have another look at its callers:
>> 
>> * read_config() has an Error ** parameter.  Bad.  Care to convert the
>>   sucker to Error?
>
> I can do it in a separate patch, unless you believe it must be
> done by this patch patch in a single step.

It *should* be a separate patch.

>> 
>> * qemu_read_config_file() doesn't report errors.  Callers:
>> 
>>   - qemu_read_default_config_file() doesn't report errors.  Its called
>>     by main(), and ...
>
> This means fopen() errors won't get reported. Good catch. I will
> send a separate fix.
>
>> 
>>   - main() reports with error_report().  Good.
>> 
> [...]
>> 
>> I think this mapping to -EINVAL is also superfluous now:
>> 
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index 6117ce5..fbefa9e 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -252,7 +252,6 @@ static int read_config(BDRVBlkdebugState *s, const char *filename,
>>          ret = qemu_config_parse(f, config_groups, filename);
>>          if (ret < 0) {
>>              error_setg(errp, "Could not parse blkdebug config file");
>> -            ret = -EINVAL;
>>              goto fail;
>
> Good catch. I will squash it into the patch.

Looking forward to v2 :)
