Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B30C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8696C21556
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bLeCgm7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8696C21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRbO-0005Fb-D5
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.ibm.com>)
 id 1kXRaZ-0004j4-QZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:12:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.ibm.com>)
 id 1kXRaX-0007i5-Kh
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:12:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09RG4Cm3142315; Tue, 27 Oct 2020 12:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=x5PvE8cXbL3NjvDKZwNRvsAOba+yps1D1RmrDPnTtHc=;
 b=bLeCgm7pro0y6yFD2tCDG3asU5iVqC1MK2y6IZnD1w9Dvek59cB9Dwh1Pj9yGHnJbRPQ
 OzLmQJ6eZFrIUmgRhmKkEnptFoUvww3oezsj9g6QMT3nyYkrC6di5pkR9lUBBR+2xBIl
 oYuQLue20qk+KxP4AGdLm3YaHeYCKiQ5Cn8al9WFgDgMXkJUKQa6urt3hBLsvEnhv4ot
 vABBwQ7h2ayqOMxnQrFNNzwexP9n6ndbvIYyumU2suBwwKB2S5lyrTrJhrj9d/t1MGDe
 TF/sjFBFQG6F9KlI6XRl+Y9exM+nhBJN9Glr1Dh6odRdqjBv/jijuU7erC4FTBjF9xP3 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34ekqd8767-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 12:12:39 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09RG4kXK145942;
 Tue, 27 Oct 2020 12:12:39 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34ekqd875t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 12:12:39 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09RG4Kxw009566;
 Tue, 27 Oct 2020 16:12:38 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03dal.us.ibm.com with ESMTP id 34cbw97cve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 16:12:38 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09RGCb7053674426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2020 16:12:38 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D95BAAC05F;
 Tue, 27 Oct 2020 16:12:37 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10966AC059;
 Tue, 27 Oct 2020 16:12:37 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2020 16:12:36 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 27 Oct 2020 12:12:36 -0400
From: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v7] sev: add sev-inject-launch-secret
In-Reply-To: <20201027133506.GC5733@habkost.net>
References: <20201022053909.34123-1-tobin@linux.ibm.com>
 <20201027133506.GC5733@habkost.net>
Message-ID: <06d453ad1dc5866e42145a6d1dd3f764@linux.vnet.ibm.com>
X-Sender: tobin@linux.ibm.com
User-Agent: Roundcube Webmail/1.0.1
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-27_08:2020-10-26,
 2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270097
Received-SPF: pass client-ip=148.163.158.5; envelope-from=tobin@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 12:12:42
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 tobin@ibm.com, qemu-devel@nongnu.org, dgilbert@redhat.com, berrange@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-10-27 09:35, Eduardo Habkost wrote:
> On Thu, Oct 22, 2020 at 01:39:09AM -0400, tobin@linux.ibm.com wrote:
>> From: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
>> 
>> AMD SEV allows a guest owner to inject a secret blob
>> into the memory of a virtual machine. The secret is
>> encrypted with the SEV Transport Encryption Key and
>> integrity is guaranteed with the Transport Integrity
>> Key. Although QEMU facilitates the injection of the
>> launch secret, it cannot access the secret.
>> 
>> Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
> 
> I was going to queue it, but unfortunately it failed to build on some 
> hosts:
> 
> https://gitlab.com/ehabkost/qemu/-/jobs/814250096
> 
> [1892/5203] Compiling C object 
> libqemu-alpha-softmmu.fa.p/monitor_misc.c.o
> FAILED: libqemu-alpha-softmmu.fa.p/monitor_misc.c.o
> arm-linux-gnueabi-gcc -Ilibqemu-alpha-softmmu.fa.p -I. -I..
> -Itarget/alpha -I../target/alpha -I../capstone/include/capstone -Iqapi
> -Itrace -Iui -Iui/shader -I/usr/include/libdrm -I/usr/include/pixman-1
> -I/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabi/glib-2.0/include
> -fdiagnostics-color=auto -pipe -Wall -Winvalid-pch -Werror -std=gnu99
> -O2 -g -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
> -Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes
> -fno-strict-aliasing -fno-common -fwrapv -Wold-style-declaration
> -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k
> -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs
> -Wendif-labels -Wexpansion-to-defined -Wno-missing-include-dirs
> -Wno-shift-negative-value -Wno-psabi -fstack-protector-strong
> -DLEGACY_RDMA_REG_MR -isystem /builds/ehabkost/qemu/linux-headers
> -isystem linux-headers -iquote /builds/ehabkost/qemu/tcg/arm -iquote .
> -iquote /builds/ehabkost/qemu -iquote /builds/ehabkost/qemu/accel/tcg
> -iquote /builds/ehabkost/qemu/include -iquote
> /builds/ehabkost/qemu/disas/libvixl -pthread -fPIC
> -isystem../linux-headers -isystemlinux-headers -DNEED_CPU_H
> '-DCONFIG_TARGET="alpha-softmmu-config-target.h"'
> '-DCONFIG_DEVICES="alpha-softmmu-config-devices.h"' -MD -MQ
> libqemu-alpha-softmmu.fa.p/monitor_misc.c.o -MF
> libqemu-alpha-softmmu.fa.p/monitor_misc.c.o.d -o
> libqemu-alpha-softmmu.fa.p/monitor_misc.c.o -c ../monitor/misc.c
> ../monitor/misc.c: In function 'gpa2hva':
> ../monitor/misc.c:686:18: error: invalid operands to binary < (have
> 'Int128' {aka 'struct Int128'} and 'uint64_t' {aka 'long long unsigned
> int'})
>      if (mrs.size < size) {
>          ~~~~~~~~ ^
> [1893/5203] Compiling C object 
> libqemu-alpha-softmmu.fa.p/softmmu_physmem.c.o
> ninja: build stopped: subcommand failed.

I am not easily able to replicate this (perhaps an issue for ARM only?).

Either way, I think it would be better to make size into an Int128
and use the appropriate comparison function. I will submit a new 
version.
I can test this better with a bit more time. For now, up to you if you
want to try building it.

-Tobin

