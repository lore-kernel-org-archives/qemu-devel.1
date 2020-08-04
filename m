Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9446C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 13:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFC62065C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 13:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9ysFISN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFC62065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2wwU-0005ke-MH
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 09:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2wvW-00058v-Kr
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 09:24:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51798
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2wvT-00073L-UY
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 09:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596547457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=eO3tgFP7toSSV7GHl54UY8wLHKqzyJZdLs+mx6kKkKA=;
 b=I9ysFISNGTL9w1lmSqTm0JboYFfsS2HfVvk9yAHM4AfYeiEQ2P+TVJs8Y/sYQf2/OBub7Y
 T+kk1QzEAhTggcro0//iuZ1HbxkH7RqL8a/uv91+ZEdnq14AuXFhDsn4i3I75w8auroJlO
 W3SAKRB2YQSotV8rftLp4uwvEC+OV8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-arnhBQPIOz26TDJAYHkjMw-1; Tue, 04 Aug 2020 09:24:16 -0400
X-MC-Unique: arnhBQPIOz26TDJAYHkjMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FD518AA0C0;
 Tue,  4 Aug 2020 13:24:14 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-162.ams2.redhat.com [10.36.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B46AB5C5B7;
 Tue,  4 Aug 2020 13:24:11 +0000 (UTC)
Subject: Re: [PATCH for-5.2 3/6] pc-bios/s390-ccw: Move the inner logic of
 find_subch() to a separate function
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20200728183734.7838-1-thuth@redhat.com>
 <20200728183734.7838-4-thuth@redhat.com> <20200803104639.5946bdd2@ibm-vm>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <44398bdc-6b72-8aff-ad25-bc0110fcfd7f@redhat.com>
Date: Tue, 4 Aug 2020 15:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200803104639.5946bdd2@ibm-vm>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/08/2020 10.46, Claudio Imbrenda wrote:
> On Tue, 28 Jul 2020 20:37:31 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> Move the code to a separate function to be able to re-use it from a
>> different spot later.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  pc-bios/s390-ccw/main.c | 99
>> ++++++++++++++++++++++++----------------- 1 file changed, 57
>> insertions(+), 42 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 9b64eb0c24..9477313188 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -51,6 +51,60 @@ unsigned int get_loadparm_index(void)
>>      return atoui(loadparm_str);
>>  }
>>  
>> +static int check_sch_no(int dev_no, int sch_no)
>> +{
>> +    bool is_virtio;
>> +    Schib schib;
>> +    int r;
>> +
>> +    blk_schid.sch_no = sch_no;
>> +    r = stsch_err(blk_schid, &schib);
>> +    if (r == 3 || r == -EIO) {
>> +        return -EIO;
>> +    }
>> +    if (!schib.pmcw.dnv) {
>> +        return false;
>> +    }
>> +
>> +    enable_subchannel(blk_schid);
>> +    cutype = cu_type(blk_schid);
>> +
>> +    /*
>> +     * Note: we always have to run virtio_is_supported() here to make
>> +     * sure that the vdev.senseid data gets pre-initialized correctly
>> +     */
>> +    is_virtio = virtio_is_supported(blk_schid);
>> +
>> +    /* No specific devno given, just return 1st possibly bootable
>> device */
>> +    if (dev_no < 0) {
>> +        switch (cutype) {
>> +        case CU_TYPE_VIRTIO:
>> +            if (is_virtio) {
>> +                /*
>> +                 * Skip net devices since no IPLB is created and
>> therefore
>> +                 * no network bootloader has been loaded
>> +                 */
>> +                if (virtio_get_device_type() != VIRTIO_ID_NET) {
>> +                    return true;
>> +                }
> 
> here it seems you are returning true for any non-network virtio device,
> is this the intended behaviour? (I know it was like this in the old
> code) like, non-block devices?

Yes. Other devices are already ignored by the virtio_is_supported() call
some lines earlier in this function.

 Thomas


