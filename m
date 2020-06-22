Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426CBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF33D2070E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlYH8Pn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF33D2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMCp-0002qZ-7Y
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jnMC5-0002M2-Is
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:09:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46169
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jnMC3-0008D6-US
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592831338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cW8VC9vhq0dx0frGYd9aipvpuwvzhoDRC8CfG41Y0cw=;
 b=TlYH8Pn7KcAWEIQQqXi8nCm1vRVsFkUBkutSO1q29KsQx1qI8HNN8ke/ddgbInwXvIcjGs
 +Fh19s9YGxqx3mWYGiDiUfZ/r1oK3WxTd6WSwSff1/zvipJSn5M2zjv1uYZGoBas59cj3E
 +tKnBcOtLuttpKeFeDGiB0LX8O2gTA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-v1ESXS4vMv-SoPVTbgx4cQ-1; Mon, 22 Jun 2020 09:08:56 -0400
X-MC-Unique: v1ESXS4vMv-SoPVTbgx4cQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88D7119200C9;
 Mon, 22 Jun 2020 13:08:55 +0000 (UTC)
Received: from [10.40.194.228] (unknown [10.40.194.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 670AE5C1BD;
 Mon, 22 Jun 2020 13:08:54 +0000 (UTC)
Subject: Re: [PATCH] qga: Use gethostname() instead of g_get_host_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <8e73f685e10c684eb5e2c88c2185504d26f024fc.1592296355.git.mprivozn@redhat.com>
 <7e31a988-7d6f-7bc5-3563-e77efff87ca3@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <1708cb61-0dbf-0537-28dd-cd82c8b30378@redhat.com>
Date: Mon, 22 Jun 2020 15:08:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <7e31a988-7d6f-7bc5-3563-e77efff87ca3@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>, vfeenstr@redhat.com,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 12:14 PM, Philippe Mathieu-Daudé wrote:
> Hi Michal,
> 
> On 6/16/20 10:34 AM, Michal Privoznik wrote:
>> Problem with g_get_host_name() is that on the first call it saves
>> the hostname into a global variable and from then on, every
>> subsequent call returns the saved hostname. Even if the hostname
>> changes. This doesn't play nicely with guest agent, because if
>> the hostname is acquired before the guest is set up (e.g. on the
>> first boot, or before DHCP) we will report old, invalid hostname.
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1845127
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
>>   qga/commands.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 52 insertions(+), 4 deletions(-)
>>
>> diff --git a/qga/commands.c b/qga/commands.c
>> index efc8b90281..ce3c2041a6 100644
>> --- a/qga/commands.c
>> +++ b/qga/commands.c
>> @@ -512,14 +512,62 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
>>       return -1;
>>   }
>>   
>> +#ifndef HOST_NAME_MAX
>> +# ifdef _POSIX_HOST_NAME_MAX
>> +#  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
>> +# else
>> +#  define HOST_NAME_MAX 255
>> +# endif
>> +#endif
>> +
>>   GuestHostName *qmp_guest_get_host_name(Error **errp)
>>   {
>>       GuestHostName *result = NULL;
>> -    gchar const *hostname = g_get_host_name();
>> -    if (hostname != NULL) {
>> -        result = g_new0(GuestHostName, 1);
>> -        result->host_name = g_strdup(hostname);
>> +    g_autofree char *hostname = NULL;
>> +
>> +    /*
>> +     * We want to avoid using g_get_host_name() because that
>> +     * caches the result and we wouldn't reflect changes in the
>> +     * host name.
>> +     */
> 
> I see there is only one g_get_host_name() call in the
> codebase, but can we have a generic qemu_get_host_name()
> helper implemented in util/oslib-*c instead?

Sure. Let me post a v2 so that I can include Richard's suggestion too.

Michal


