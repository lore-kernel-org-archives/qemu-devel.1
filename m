Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5164C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417862465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g6hsBsCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417862465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnQz-0003j8-VG
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1ifnOj-0001xU-1T
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1ifnOd-0006DD-KD
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:02:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1ifnOd-0006BJ-Ak
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:02:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDFvObT064759;
 Fri, 13 Dec 2019 16:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=NsYR5Ax8OOzmGyTmAwImDHPI/KW8a7HCvyzWAV4cLSU=;
 b=g6hsBsCbR2IkrV9gDYPFE/5Ow0TG2OzUE4knRJhAJhstPZ8tNkr51XXpohldsAJp8mJ3
 FmtVyHXsK94Kpz4EaqEVz2dDDh5EcALzgxGentXMYFnmgM+uITxkLd/e98klsao7s3ll
 ZHnC/itOj2prn9Lyig3NKTrXVG7ZQqKbU1tbRLJyd56dTrRS2H3Q40jm/b3sNJ2qZwp2
 JzGTwCN4qtEnUZq+aefIz/H+kduSlM7qLPG8pc59m9HQWEtK/IzXqeOay3MahYqAAZ3T
 JNULIPjKfRyrc0QoupYxSpKT8nzw8v7EeS3mTf5/tixESnM8o0cUl0YNU7k/p1dOBCVy fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2wrw4nps7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 16:02:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDFxUgu060401;
 Fri, 13 Dec 2019 16:02:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2wvd1ge8js-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 16:02:25 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBDG2OEx010342;
 Fri, 13 Dec 2019 16:02:24 GMT
Received: from [10.175.208.200] (/10.175.208.200)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Dec 2019 08:02:24 -0800
Subject: Re: [PATCH 025/104] virtiofsd: Add Makefile wiring for virtiofsd
 contrib
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-26-dgilbert@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <a3a3b681-b411-0c22-291a-9e0cd9116c19@oracle.com>
Date: Fri, 13 Dec 2019 16:02:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-26-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130130
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/2019 16:37, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Wire up the building of the virtiofsd in contrib.

s/contrib/tools/

otherwise

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

> 
> virtiofsd relies on Linux-specific system calls and seccomp.  Anyone
> wishing to port it to other host operating systems should do so
> carefully and without reducing security.
> 
> Only allow building on Linux hosts.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   Makefile                      |  8 ++++++++
>   Makefile.objs                 |  1 +
>   tools/virtiofsd/Makefile.objs | 10 ++++++++++
>   3 files changed, 19 insertions(+)
>   create mode 100644 tools/virtiofsd/Makefile.objs
> 
> diff --git a/Makefile b/Makefile
> index b437a346d7..b7f7019a50 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -322,6 +322,8 @@ HELPERS-y =
>   HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = qemu-bridge-helper$(EXESUF)
>   
>   ifdef CONFIG_LINUX
> +HELPERS-y += virtiofsd$(EXESUF)
> +
>   ifdef CONFIG_VIRGL
>   ifdef CONFIG_GBM
>   HELPERS-y += vhost-user-gpu$(EXESUF)
> @@ -430,6 +432,7 @@ dummy := $(call unnest-vars,, \
>                   elf2dmp-obj-y \
>                   ivshmem-client-obj-y \
>                   ivshmem-server-obj-y \
> +                virtiofsd-obj-y \
>                   rdmacm-mux-obj-y \
>                   libvhost-user-obj-y \
>                   vhost-user-scsi-obj-y \
> @@ -674,6 +677,11 @@ rdmacm-mux$(EXESUF): LIBS += "-libumad"
>   rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
>   	$(call LINK, $^)
>   
> +ifdef CONFIG_LINUX # relies on Linux-specific syscalls
> +virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
> +	$(call LINK, $^)
> +endif
> +
>   vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) libqemuutil.a libqemustub.a
>   	$(call LINK, $^)
>   
> diff --git a/Makefile.objs b/Makefile.objs
> index 11ba1a36bd..b5f667a4ba 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -125,6 +125,7 @@ vhost-user-blk-obj-y = contrib/vhost-user-blk/
>   rdmacm-mux-obj-y = contrib/rdmacm-mux/
>   vhost-user-input-obj-y = contrib/vhost-user-input/
>   vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
> +virtiofsd-obj-y = tools/virtiofsd/
>   
>   ######################################################################
>   trace-events-subdirs =
> diff --git a/tools/virtiofsd/Makefile.objs b/tools/virtiofsd/Makefile.objs
> new file mode 100644
> index 0000000000..67be16332c
> --- /dev/null
> +++ b/tools/virtiofsd/Makefile.objs
> @@ -0,0 +1,10 @@
> +virtiofsd-obj-y = buffer.o \
> +                  fuse_opt.o \
> +                  fuse_log.o \
> +                  fuse_loop_mt.o \
> +                  fuse_lowlevel.o \
> +                  fuse_signals.o \
> +                  fuse_virtio.o \
> +                  helper.o \
> +                  passthrough_ll.o
> +
> 


