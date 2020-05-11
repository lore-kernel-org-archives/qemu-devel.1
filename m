Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F2C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF75A20736
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzR1Whau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF75A20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYDCr-0004U0-Mc
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYDBm-0003eG-4V
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:30:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYDBk-0003ix-Mg
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589221803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyMiAPXgCTwsNdpQz0KKozmav9hMXji3AVCCoO4tLQ4=;
 b=UzR1WhaummzxMiDYIb7zJ2yJKY+ZJSam/k1vdWRNLFgVXk353C2+uegMspIr4n64TW1q92
 EPLgzd0AAzeEI5mFU5lhl8z25XdZt2jio+cm/LhxckDTx3lCxI3WDFxczJA26fdtVqPGeH
 j8+SlfZaGjEvggQiFWn3ZkvvmW75Nek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-Pp8IpQNVPQGSCU-lpyIrzQ-1; Mon, 11 May 2020 14:30:01 -0400
X-MC-Unique: Pp8IpQNVPQGSCU-lpyIrzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17B531899520;
 Mon, 11 May 2020 18:30:00 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4798A5C1B5;
 Mon, 11 May 2020 18:29:59 +0000 (UTC)
Subject: Re: [PATCH v3 7/9] qcow2: Expose bitmaps' size during measure
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-8-eblake@redhat.com>
 <98430e29-65e8-c0c7-c172-fdaa121f97c5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <998d0a6d-af8c-69d1-50fe-11a31896d7f3@redhat.com>
Date: Mon, 11 May 2020 13:29:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <98430e29-65e8-c0c7-c172-fdaa121f97c5@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Nir Soffer <nsoffer@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 6:50 AM, Max Reitz wrote:
> On 08.05.20 20:03, Eric Blake wrote:
>> It's useful to know how much space can be occupied by qcow2 persistent
>> bitmaps, even though such metadata is unrelated to the guest-visible
>> data.  Report this value as an additional field, present when
>> measuring an existing image and the output format supports bitmaps.
>> Update iotest 178 and 190 to updated output, as well as new coverage
>> in 190 demonstrating non-zero values made possible with the
>> recently-added qemu-img bitmap command.
>>
>> The addition of a new field demonstrates why we should always
>> zero-initialize qapi C structs; while the qcow2 driver still fully
>> populates all fields, the raw and crypto drivers had to be tweaked to
>> avoid uninitialized data.
>>
>> See also: https://bugzilla.redhat.com/1779904
>>
>> Reported-by: Nir Soffer <nsoffer@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>> +#
>> +# @bitmaps: Additional size required for bitmap metadata in a source image,
> 
> s/in/from/?  Otherwise it sounds like this would be about allocation in
> the source, which it clear can’t be, but, well.
> 

Yes, 'from' sounds nicer, especially since the size requirements being 
measured depend on the destination's cluster size (which may be 
different from the source's cluster size).

>> +#           if that bitmap metadata can be copied in addition to guest
>> +#           contents. (since 5.1)
> 
> [...]
> 

>> +    /*
>> +     * Remove data clusters that are not required.  This overestimates the
>>        * required size because metadata needed for the fully allocated file is
>> -     * still counted.
>> +     * still counted.  Show bitmaps only if both source and destination
>> +     * would support them.
>>        */
>>       info->required = info->fully_allocated - virtual_size + required;
>> +    info->has_bitmaps = version >= 3 && in_bs &&
>> +        bdrv_dirty_bitmap_supported(in_bs);
> 
> Why is it important whether the source format supports persistent dirty
> bitmaps?

If the source format does not support bitmaps, there is nothing to copy 
over.  Reporting '0' would work, but adds verbosity.  It also becomes a 
question as to whether 'qemu-img convert --bitmaps' should silently 
ignore such sources, or loudly error out that the option is unsupported 
because the source lacks bitmaps.  I could lean either way.

> 
> I’m asking because I’d like there to be some concise reason when and why
> the @bitmaps field appears.  “Whenever the target supports bitmaps” is
> more concise than “When both source and target support bitmaps”.  Also,
> the latter is not really different from “When any bitmap data can be
> copied”, but in the latter case we should not show it when there are no
> bitmaps in the source (even though the format supports them).
> 
> Or from the other perspective: As a user, I would never be annoyed by
> the @bitmaps field being present.  I don’t mind a “0”.
> OTOH, what information can it convey to me that it it’s optional and
> sometimes not present?

The impact to the iotests .out files is larger if I do not require that 
the source supports bitmaps (more lines of 'bitmaps: 0' added).  I'm 
fine doing that, if we decide we're okay with the simpler definition of 
'"bitmaps" is present if the destination supports them' (rather than 
this version's implementation of '"bitmaps" is present if both the 
source and destination support them').

> I can see these cases:
> 
> - That the source format doesn’t support bitmaps?  I want to convert it
> to something else anyway, so I don’t really care about what the source
> format can or can’t do.
> 
> - That the destination doesn’t support bitmaps?  Ah, yes, the fact that
> the bitmap field is missing might be a warning sign for this.
> 
> - That qemu is too old to copy bitmaps?  Same here.

In fact, that argument is a GOOD reason to output 'bitmaps: 0' in as 
many cases as possible, because it then becomes a side-effect witness of 
whether 'qemu-img convert --bitmaps' is even understood.

> 
> - That there are no bitmaps in the source?  OK, but then I disregard the
> @bitmaps field anyway, present or not.
> 
> So from that standpoint, the best use seems to me to take “The @bitmaps
> field isn’t present” as kind of a warning that something in the convert
> process won’t support copying bitmaps.  If it’s present, all is well.
> So basically there’d be an iff relationship between “measure reports
> @bitmaps” and “convert --bitmap can work”.

Yes, I can make that tweak for v4.

> 
> But the distinction between “the source format doesn’t support bitmaps”
> and “the source image doesn’t have bitmaps” doesn’t seem that important
> to me to make it visible in the interface.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


