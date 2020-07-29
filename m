Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2CFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1517320656
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbYSuN2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1517320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0juU-0007fS-CL
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 07:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0jtd-0006wf-G3
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 07:05:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0jtb-00070U-Sw
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 07:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596020715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=yEDwsRo0PDGIsL3U0H+xqCsH09ia6cT31Fq642LYSoc=;
 b=SbYSuN2VOb1LVD+xi6Fz3B+e4xACBkBQpc97d4vC1yL1/FsA1+v/njBX/1tzeek2wsNZuZ
 3fyT3lJpLlqmDFUZZ01PgfntuDd/UU5MYR7uV+pRf8FkmiDiR67tQwmqm1xU/iVYfvgB5t
 nV4993E9KRTaWxcCUb7/ckGM2OTjNi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-OJ6VthihP22nYa8UjqkwTw-1; Wed, 29 Jul 2020 07:05:13 -0400
X-MC-Unique: OJ6VthihP22nYa8UjqkwTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E687F18A1DFB;
 Wed, 29 Jul 2020 11:05:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-171.ams2.redhat.com [10.36.112.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ED105C1BD;
 Wed, 29 Jul 2020 11:05:10 +0000 (UTC)
Subject: Re: [PATCH for-5.2 2/6] pc-bios/s390-ccw: Move ipl-related code from
 main() into a separate function
To: Cornelia Huck <cohuck@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
 <20200728183734.7838-3-thuth@redhat.com>
 <20200729104721.6f2b8162.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6be1e380-4841-a5ea-f710-26988cdcc441@redhat.com>
Date: Wed, 29 Jul 2020 13:05:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200729104721.6f2b8162.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.74; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 03:32:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/2020 10.47, Cornelia Huck wrote:
> On Tue, 28 Jul 2020 20:37:30 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> Let's move this part of the code into a separate function to be able
>> to use it from multiple spots later.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  pc-bios/s390-ccw/main.c | 20 ++++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 146a50760b..9b64eb0c24 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -223,14 +223,8 @@ static void virtio_setup(void)
>>      }
>>  }
>>  
>> -int main(void)
>> +static void ipl_boot_device(void)
>>  {
>> -    sclp_setup();
>> -    css_setup();
>> -    boot_setup();
>> -    find_boot_device();
>> -    enable_subchannel(blk_schid);
>> -
>>      switch (cutype) {
>>      case CU_TYPE_DASD_3990:
>>      case CU_TYPE_DASD_2107:
>> @@ -242,8 +236,18 @@ int main(void)
>>          break;
>>      default:
>>          print_int("Attempting to boot from unexpected device type", cutype);
>> -        panic("");
>> +        panic("\nBoot failed.\n");
> 
> Maybe "Boot failed: no supported device type"?

The print_int right before already talks about "unexpected device type",
so I think the simple "Boot failed" should be enough?

>>      }
>> +}
>> +
>> +int main(void)
>> +{
>> +    sclp_setup();
>> +    css_setup();
>> +    boot_setup();
>> +    find_boot_device();
>> +    enable_subchannel(blk_schid);
>> +    ipl_boot_device();
>>  
>>      panic("Failed to load OS from hard disk\n");
>>      return 0; /* make compiler happy */
> 
> Anyway,
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks!

 Thomas


