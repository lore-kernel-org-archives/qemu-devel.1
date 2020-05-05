Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649B9C47257
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38262073B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICNuhm8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38262073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzlY-0006UC-T1
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVzWx-0004qf-Qo
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:30:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41881
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVzWw-0002RF-L4
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQJsRkYGCTfpMsGb1q3vhZlyUvLyz5hR9o+Bv6uq1yA=;
 b=ICNuhm8SZFyRu+edW33r2BTNGkt+Bh7Cl3xh/j7pK0KSKKRo7fO7hA4pPohXo8SHAFRH2c
 gEkC3rfxjhKNrcsmf8ENFhf6nBEalkFwejoQoofLFWsGvlbFuaAhIkQXo/YQb4fnjzqcdt
 qoO6Vf43gk0a/xM2I0dUEjSCr474WF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-enNGYDM8O1KeJfpZs3sVGg-1; Tue, 05 May 2020 11:30:34 -0400
X-MC-Unique: enNGYDM8O1KeJfpZs3sVGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E189E107ACF4;
 Tue,  5 May 2020 15:30:33 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 721F4649D0;
 Tue,  5 May 2020 15:30:16 +0000 (UTC)
Subject: Re: [PATCH v5 3/7] qcow: Tolerate backing_fmt=, but warn on
 backing_fmt=raw
To: Kevin Wolf <kwolf@redhat.com>
References: <20200403175859.863248-1-eblake@redhat.com>
 <20200403175859.863248-4-eblake@redhat.com>
 <20200505073542.GA5759@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4b4f83fb-eb3d-6ae5-116a-da921ee2b403@redhat.com>
Date: Tue, 5 May 2020 10:30:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505073542.GA5759@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, kchamart@redhat.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 2:35 AM, Kevin Wolf wrote:
> Am 03.04.2020 um 19:58 hat Eric Blake geschrieben:
>> qcow has no space in the metadata to store a backing format, and there
>> are existing qcow images backed both by raw or by other formats
>> (usually qcow) images, reliant on probing to tell the difference.
>> While we don't recommend the creation of new qcow images (as qcow2 is
>> hands-down better), we can at least insist that if the user does
>> request a specific format without using -u, then it must be non-raw
>> (as a raw backing file that gets inadvertently edited into some other
>> format can form a security hole); if the user does not request a
>> specific format or lies when using -u, then the status quo of probing
>> for the backing format remains intact (although an upcoming patch will
>> warn when omitting a format request).  Thus, when this series is
>> complete, the only way to use a backing file for qcow without
>> triggering a warning is when using -F if the backing file is non-raw
>> to begin with.  Note that this is only for QemuOpts usage; there is no
>> change to the QAPI to allow a format through -blockdev.
>>
>> Add a new iotest 290 just for qcow, to demonstrate the new warning.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> Somehow this feels backwards. Not specifying the backing file format at
> all isn't any safer than explicitly specifying raw.
> 
> If there is a difference at all, I would say that explicitly specifying
> raw means that the user is aware what they are doing. So we would have
> more reason to warn against raw images if the backing format isn't
> specified at all because then the user might not be aware that they are
> using a backing file that probes as raw.

Prior to this patch, -F does not work with qcow.  And even with this 
patch, we still cannot store the explicit value of -F in the qcow file. 
Anything that does not use -F must continue to work for now (although it 
may now warn, and in fact must warn if we deprecate it), while anything 
explicit is free to fail (since it failed already), but could also be 
made to work (if letting it work is nicer than making it fail, and where 
"work" may still include a warning, although it's pointless to have 
something brand new that works but is deprecated out of the box).  So 
the following is my summary of the two options we can choose between:

Option 1, qcow backed by raw is more common than qcow backed by other, 
so we want:
raw <- qcow, no -F: work without warning (but if backing file is edited, 
a future probe seeing non-raw would break image)
raw <- qcow, with -F: work without warning (but if backing file is 
edited, a future probe seeing non-raw would break image)
other <- qcow, no -F: works but issues a warning (but backing file will 
always probe correctly)
other <- qcow, with -F: fails (we cannot honor the user's explicit 
request, because we would still have to probe)

Option 2, qcow backed by other is more common than qcow backed by raw, 
so we want:
raw <- qcow, no -F: works but issues a warning (using a raw backing file 
without explicit buy-in is risky)
raw <- qcow, with -F: works but issues a warning (explicit buy-in will 
still require subsequent probing, and a backing file could change which 
would break image)
other <- qcow, no -F: works without warning
other <- qcow, with -F: works without warning (later probing will still 
see non-raw)

It looks like you are leaning more towards option 1, while my patch 
leaned more towards option 2.  Anyone else want to chime in with an 
opinion on which is safer vs. easier?


>> @@ -953,6 +954,13 @@ static int coroutine_fn qcow_co_create_opts(BlockDriver *drv,
>>       };
>>
>>       /* Parse options and convert legacy syntax */
>> +    backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
>> +    if (backing_fmt && !strcmp(backing_fmt, "raw")) {
>> +        error_setg(errp, "qcow cannot store backing format; an explicit "
>> +                   "backing format of raw is unsafe");
> 
> Does this message tell that an implicit backing format of raw is safe?

If we go with option 2, are we trying to deprecate ALL use of raw as a 
backing file to qcow, regardless of whether the user was explicit about 
it?  If we go with option 1, then we are instead deprecating any use of 
non-raw as a backing file to qcow.

At the end of the day, we are trying to discourage users from creating 
new qcow files in the first place; qcow2 is much better.  We still have 
to read existing qcow images with backing files, but maybe we want:

Option 3:
completely deprecate qcow images with backing files, as there is no safe 
way to do things favoring either raw (option 1) or non-raw (option 2), 
and therefore accept -F solely for convenience with the rest of the 
series, but always issue a warning regardless of whether -F was present.

> 
>> +        ret = -EINVAL;
>> +        goto fail;
>> +    }
> 
> The commit message promises a warning. This is not a warning, but a hard
> error.

Once we decide which behavior we want, I'll make sure the commit message 
matches the behavior.  Remember, for implicit images, we are starting a 
deprecation clock; for explicit images, it previously failed, so 
continuing to fail is still viable.


>> +echo
>> +echo "== qcow backed by raw =="
>> +
>> +rm "$TEST_IMG.base"
>> +truncate --size=$size "$TEST_IMG.base"
>> +_make_test_img -b "$TEST_IMG.base"
>> +_img_info
>> +_make_test_img -b "$TEST_IMG.base" -F raw
>> +_img_info
> 
> This test doesn't tell the difference between a warning and an error. In
> both cases, the image would look the same: Either because it was
> successfully created or because the old version is still there.

Indeed, I can make the test more robust.  But more importantly, we need 
consensus on _what_ we want behavior to be, and write the test along 
those lines.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


