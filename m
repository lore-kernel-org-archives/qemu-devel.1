Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448C9C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECA820855
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAIvRtfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECA820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjX7-0007cX-GH
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 09:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGjVP-0005qT-V9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:54:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46039
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGjVK-0005x7-IO
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599832457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPY+RKHV6IhbvhxwGSp1G7bfI3Gu9E+CxFqgV6C2vEY=;
 b=BAIvRtfi79H5ptV8Q7MH6t1r2T/XpfBb9lSJux27s9tYJGKlqZbR/tTSn0Ev2Sc1bntEyH
 +wuX5+r+7AJKOYlqwlPhTiN28CoPVmUjOkQx47DLXnCsql6H0XgWyCWoB/Efg4YHkVIupX
 B6KS3I3D2CvlbWXJicWTwj69wnaDWqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-Wu103hO5NtS6k0Arj7cUXw-1; Fri, 11 Sep 2020 09:54:15 -0400
X-MC-Unique: Wu103hO5NtS6k0Arj7cUXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18218802B6D;
 Fri, 11 Sep 2020 13:54:14 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-115-1.ams2.redhat.com [10.36.115.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A586419C59;
 Fri, 11 Sep 2020 13:54:01 +0000 (UTC)
Subject: Re: [PATCH v5 6/8] s390/sclp: add extended-length sccb support for
 kvm guest
From: Thomas Huth <thuth@redhat.com>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-7-walling@linux.ibm.com>
 <43af1e04-b9c9-2704-9cef-735a9b283be7@redhat.com>
Message-ID: <c5663f7b-0799-eddd-bae8-26cb08d6eca7@redhat.com>
Date: Fri, 11 Sep 2020 15:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <43af1e04-b9c9-2704-9cef-735a9b283be7@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 pbonzini@redhat.com, sumanthk@linux.ibm.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/2020 15.41, Thomas Huth wrote:
> On 10/09/2020 11.36, Collin Walling wrote:
>> As more features and facilities are added to the Read SCP Info (RSCPI)
>> response, more space is required to store them. The space used to store
>> these new features intrudes on the space originally used to store CPU
>> entries. This means as more features and facilities are added to the
>> RSCPI response, less space can be used to store CPU entries.
>>
>> With the Extended-Length SCCB (ELS) facility, a KVM guest can execute
>> the RSCPI command and determine if the SCCB is large enough to store a
>> complete reponse. If it is not large enough, then the required length
>> will be set in the SCCB header.
>>
>> The caller of the SCLP command is responsible for creating a
>> large-enough SCCB to store a complete response. Proper checking should
>> be in place, and the caller should execute the command once-more with
>> the large-enough SCCB.
>>
>> This facility also enables an extended SCCB for the Read CPU Info
>> (RCPUI) command.
>>
>> When this facility is enabled, the boundary violation response cannot
>> be a result from the RSCPI, RSCPI Forced, or RCPUI commands.
>>
>> In order to tolerate kernels that do not yet have full support for this
>> feature, a "fixed" offset to the start of the CPU Entries within the
>> Read SCP Info struct is set to allow for the original 248 max entries
>> when this feature is disabled.
>>
>> Additionally, this is introduced as a CPU feature to protect the guest
>> from migrating to a machine that does not support storing an extended
>> SCCB. This could otherwise hinder the VM from being able to read all
>> available CPU entries after migration (such as during re-ipl).
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
> [...]
>>  /* Provide information about the configuration, CPUs and storage */
>>  static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>  {
>> @@ -89,10 +112,15 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>      int rnsize, rnmax;
>>      IplParameterBlock *ipib = s390_ipl_get_iplb();
>>      int required_len = SCCB_REQ_LEN(ReadInfo, machine->possible_cpus->len);
>> -    int offset_cpu = offsetof(ReadInfo, entries);
>> +    int offset_cpu = s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) ?
>> +                     offsetof(ReadInfo, entries) :
>> +                     SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET;
> 
> Sorry, but I'm having somewhat trouble to understand this...
> What's the difference between offsetof(ReadInfo, entries) and
> SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET ? Aren't both terms resulting in the
> value 128 ?

Ah, well, the answer is clear after looking at patch 8/8 ... ReadInfo is
extended there, so offsetof(ReadInfo, entries) will result in a
different value.
Might have been better to move the above hunk into patch 8/8, but if you
want to keep it here, that's now ok for me, too.

Reviewed-by: Thomas Huth <thuth@redhat.com>


