Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C018AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204CD2065D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnzBkNzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204CD2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kODad-0008ML-5v
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 01:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kODSS-00083p-Gt
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 01:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kODSQ-0005Yj-RN
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 01:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601615894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWVFIUqGEIclDGfyH0Lcc7BBj/UYWXLCnhEBFb1Y/54=;
 b=dnzBkNzKJ9Zk9EwMERK4gbsyRjSrIF4K25Fg4hXxihUYvNZ/JO9ZX3rMD6Dun3qcOVs1Kv
 3cEdm1saFrWZaOSMXn1jWzjcMYsSlXsWCSIpTnjUIGg8w/P0eIiuiZ2jiWi0XlWG9P9A9/
 oii8/lt56RJSR0j36i1qgiDCy7d24rY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-6MA3xlvSMZaDBHwAuKWW0A-1; Fri, 02 Oct 2020 01:18:09 -0400
X-MC-Unique: 6MA3xlvSMZaDBHwAuKWW0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A91FA1DE08;
 Fri,  2 Oct 2020 05:18:08 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8261160C17;
 Fri,  2 Oct 2020 05:18:07 +0000 (UTC)
Subject: Re: [PATCH] elfload: use g_new instead of malloc
To: Markus Armbruster <armbru@redhat.com>,
 Elena Afanasova <eafanasova@gmail.com>
References: <20201001123807.42978-1-eafanasova@gmail.com>
 <87r1qhtdxt.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b4ab229a-0e84-9d0b-1287-846c52a667bb@redhat.com>
Date: Fri, 2 Oct 2020 07:18:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87r1qhtdxt.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/2020 07.05, Markus Armbruster wrote:
> Elena Afanasova <eafanasova@gmail.com> writes:
> 
>> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
>> ---
>>  bsd-user/elfload.c | 92 +++++++++++++++-------------------------------
>>  1 file changed, 30 insertions(+), 62 deletions(-)
>>
>> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
>> index 32378af7b2..e10ca54eb7 100644
>> --- a/bsd-user/elfload.c
>> +++ b/bsd-user/elfload.c
>> @@ -867,18 +867,14 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
>>          if (sizeof(struct elf_phdr) * interp_elf_ex->e_phnum > TARGET_PAGE_SIZE)
>>              return ~(abi_ulong)0UL;
>>  
>> -        elf_phdata =  (struct elf_phdr *)
>> -                malloc(sizeof(struct elf_phdr) * interp_elf_ex->e_phnum);
>> -
>> -        if (!elf_phdata)
>> -          return ~((abi_ulong)0UL);
>> +        elf_phdata = g_new(struct elf_phdr, interp_elf_ex->e_phnum);
>>  
>>          /*
>>           * If the size of this structure has changed, then punt, since
>>           * we will be doing the wrong thing.
>>           */
>>          if (interp_elf_ex->e_phentsize != sizeof(struct elf_phdr)) {
>> -            free(elf_phdata);
>> +            g_free(elf_phdata);
>>              return ~((abi_ulong)0UL);
>>          }
>>  
>> @@ -890,9 +886,8 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
>>          }
>>          if (retval < 0) {
>>                  perror("load_elf_interp");
>> +                g_free(elf_phdata);
>>                  exit(-1);
>> -                free (elf_phdata);
>> -                return retval;
> 
> Deleting return looks wrong.

Why? There is an exit(-1) right in front of it, so this is dead code...
well, maybe that should be done in a separate patch, or at least
mentioned in the patch description, though.

 Thomas


