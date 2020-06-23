Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47348C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10653206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X4G1bsSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10653206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndv3-0002tr-8b
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jndu6-0002Na-Ue
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:03:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jndu4-0000Kz-2n
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:03:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05N820vt131892;
 Tue, 23 Jun 2020 08:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=nYKTKpOuoLGyRuGF6QAW82JQqo/N/GHZYWaG30hEBBU=;
 b=X4G1bsSNFdZJsdQSEH2MfPTc8b3pPe0rsMjVF7LlA1aomD9kar6zFUDZ0YdfdIxkFFW7
 ++t+TPRAN3ATcUQDPly2r6+Dlp5BTX+eoS2Kf1uUftmCGfQ1LstsH03jAuyQWef+QCSW
 utA/tsXBruY8q+FaIrZuaRoob+n35qwR1bJbHVsR4jg8lyBtqkm8GnnmVN80Lx/fSmnJ
 xJ+NrP6RUhGILVj24G9fjEw4sZ6ebxMGkOptZsC004QxOhEuuI+6sywrXO4F9cmoFklH
 CXGDi/ntpMj1/1vqBSOJ7uSDM5dKiGkvkabPftCeHRZydNJ+gRFFiz2ukESLbbpPGDVy lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 31sebbbpjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Jun 2020 08:03:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05N7w7o9067488;
 Tue, 23 Jun 2020 08:03:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 31sv7rddh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2020 08:03:25 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05N83MZK030269;
 Tue, 23 Jun 2020 08:03:22 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 23 Jun 2020 08:03:22 +0000
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 5C400888E5B; Tue, 23 Jun 2020 09:03:19 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH] fuzz: do not use POSIX shm for coverage bitmap
In-Reply-To: <20200622165040.15121-1-alxndr@bu.edu>
References: <20200622165040.15121-1-alxndr@bu.edu>
Date: Tue, 23 Jun 2020 09:03:19 +0100
Message-ID: <m24kr2cipk.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006230062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 cotscore=-2147483648
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006230063
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 04:03:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 f4bug@amsat.org, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On Monday, 2020-06-22 at 12:50:40 -04, Alexander Bulekov wrote:
> We used shm_open with mmap to share libfuzzer's coverage bitmap with
> child (runner) processes. The same functionality can be achieved with
> MAP_SHARED | MAP_ANONYMOUS, since we do not care about naming or
> permissioning the shared memory object.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
> This might fix:
> qemu-fuzz-i386-target-virtio-net-socket: Unexpected-exit in
> counter_shm_init 
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=23636 (private link)
>
> oss-fuzz does not provide access to /dev/, so it is likely that shm_open
> breaks, when it tries to access /dev/shm. This seems likely, based on
> the oss-fuzz minijail setup:
> https://github.com/google/oss-fuzz/blob/3740c751fd9edea138c17783995d370d6b1b89bc/infra/base-images/base-runner/run_minijail
>
>  tests/qtest/fuzz/fork_fuzz.c | 40 ++++++++++++------------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
>
> diff --git a/tests/qtest/fuzz/fork_fuzz.c b/tests/qtest/fuzz/fork_fuzz.c
> index 2bd0851903..6ffb2a7937 100644
> --- a/tests/qtest/fuzz/fork_fuzz.c
> +++ b/tests/qtest/fuzz/fork_fuzz.c
> @@ -17,39 +17,25 @@
>  
>  void counter_shm_init(void)
>  {
> -    char *shm_path = g_strdup_printf("/qemu-fuzz-cntrs.%d", getpid());
> -    int fd = shm_open(shm_path, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
> -    g_free(shm_path);
> -
> -    if (fd == -1) {
> -        perror("Error: ");
> -        exit(1);
> -    }
> -    if (ftruncate(fd, &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START) == -1) {
> -        perror("Error: ");
> -        exit(1);
> -    }
> -    /* Copy what's in the counter region to the shm.. */
> -    void *rptr = mmap(NULL ,
> -            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
> -            PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> -    memcpy(rptr,
> +    /* Copy what's in the counter region to a temporary buffer.. */
> +    void *copy = malloc(&__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
> +    memcpy(copy,
>             &__FUZZ_COUNTERS_START,
>             &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
>  
> -    munmap(rptr, &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
> -
> -    /* And map the shm over the counter region */
> -    rptr = mmap(&__FUZZ_COUNTERS_START,
> -            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
> -            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, 0);
> -
> -    close(fd);
> -
> -    if (!rptr) {
> +    /* Map a shared region over the counter region */
> +    if (mmap(&__FUZZ_COUNTERS_START,
> +             &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
> +             PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED | MAP_ANONYMOUS,
> +             0, 0) == MAP_FAILED) {

It's not really necessary I guess, but for completeness you might want
to free(copy) here too.

Otherwise, this looks good, so:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren

>          perror("Error: ");
>          exit(1);
>      }
> +
> +    /* Copy the original data back to the counter-region */
> +    memcpy(&__FUZZ_COUNTERS_START, copy,
> +           &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
> +    free(copy);
>  }
>  
>  
> -- 
> 2.26.2

