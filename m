Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F599C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3FA206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nz1jqrPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3FA206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPuO-0000Mq-3D
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jYPth-0008Gw-Fv
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:04:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jYPtf-00059s-Qo
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:04:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C83DC9173976;
 Tue, 12 May 2020 08:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=tql5MQ2IOYSdhP0iJ2yZU35u/4Sey4OMTPpbZxAMhlM=;
 b=Nz1jqrPQB2TsPHMhMsQmI12G8PMWWn/DFmXyI2oUloR+/mAd1rzMaVBciF9nIialrIlp
 lL/ouT6l0dSPlGdPVOPQg7DYjRfbDMFX0fVIHz8d5zkE9/myEI1B3exFERLbkKJRDwji
 rZS5efoaTzNBssGVb3soIizYStpkZYYe2fPOxCC3hGYTB/n3G512qSS5RJz1fdefVhIq
 xD6Inof3zZ4aRgn361CIV8+8Hnw7L/mA9BEM8ZzDY1v1YuHHNDXTxboosonxesUJWjyA
 s9NLS9I8DIbakNHNf/wnJunusoRvJy8QmmksPLpNtAJWEmws2qSAsPWaYwEk9q2oWlIV 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 30x3gshdsr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 08:04:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C83gUS080240;
 Tue, 12 May 2020 08:04:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 30x63pa7j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 08:04:13 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04C84CEU025602;
 Tue, 12 May 2020 08:04:12 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 01:04:12 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id EEC286920DBD; Tue, 12 May 2020 09:04:09 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/2] char-file: add test for distinct path= and pathin=
In-Reply-To: <20200512034750.5773-3-alxndr@bu.edu>
References: <20200512034750.5773-1-alxndr@bu.edu>
 <20200512034750.5773-3-alxndr@bu.edu>
Date: Tue, 12 May 2020 09:04:09 +0100
Message-ID: <m2r1vplgue.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=59
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=59 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120068
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 03:59:36
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: marcandre.lureau@gmail.com, bsd@redhat.com, berrange@redhat.com,
 stefanha@redhat.com, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On Monday, 2020-05-11 at 23:47:50 -04, Alexander Bulekov wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Thanks for making those changes.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

> ---
>  tests/test-char.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>
> diff --git a/tests/test-char.c b/tests/test-char.c
> index 3afc9b1b8d..6c66fae86a 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -1228,6 +1228,101 @@ static void char_file_test_internal(Chardev *ext_chr, const char *filepath)
>      g_free(out);
>  }
>  
> +static int file_can_read(void *opaque)
> +{
> +    return 4096;
> +}
> +
> +static void file_read(void *opaque, const uint8_t *buf, int size)
> +{
> +    int ret;
> +    Chardev *chr = *(Chardev **)opaque;
> +    g_assert_cmpint(size, <=, file_can_read(opaque));
> +
> +    g_assert_cmpint(size, ==, 6);
> +    g_assert(strncmp((const char *)buf, "hello!", 6) == 0);
> +    ret = qemu_chr_write_all(chr, (const uint8_t *)"world!", 6);
> +    g_assert_cmpint(ret, ==, 6);
> +    quit = true;
> +}
> +
> +static void char_file_separate_input_file(void)
> +{
> +    char *tmp_path = g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
> +    char *in;
> +    char *out;
> +    QemuOpts *opts;
> +    Chardev *chr;
> +    ChardevFile file = {};
> +    CharBackend be;
> +    ChardevBackend backend = { .type = CHARDEV_BACKEND_KIND_FILE,
> +                               .u.file.data = &file };
> +    char *contents = NULL;
> +    gsize length;
> +    int ret;
> +    time_t in_mtime;
> +    GStatBuf file_stat;
> +
> +    in = g_build_filename(tmp_path, "in", NULL);
> +    out = g_build_filename(tmp_path, "out", NULL);
> +
> +    ret = g_file_set_contents(in, "hello!", 6, NULL);
> +    g_assert(ret == TRUE);
> +    g_stat(in, &file_stat);
> +    in_mtime = file_stat.st_mtime;
> +    /*
> +     * Sleep to ensure that if the following actions modify the file, the mtime
> +     * will be different
> +     */
> +    sleep(1);
> +    opts = qemu_opts_create(qemu_find_opts("chardev"), "serial-id",
> +                            1, &error_abort);
> +    qemu_opt_set(opts, "backend", "file", &error_abort);
> +    qemu_opt_set(opts, "pathin", in, &error_abort);
> +    qemu_opt_set(opts, "path", out, &error_abort);
> +
> +    chr = qemu_chr_new_from_opts(opts, NULL, NULL);
> +    qemu_chr_fe_init(&be, chr, &error_abort);
> +
> +    file.has_in = true;
> +    file.in = in;
> +    file.out = out;
> +
> +
> +    qemu_chr_fe_set_handlers(&be, file_can_read,
> +                             file_read,
> +                             NULL, NULL, &chr, NULL, true);
> +
> +    chr = qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
> +                               NULL, &error_abort);
> +    g_assert_nonnull(chr);
> +
> +    main_loop(); /* should call file_read, and copy contents of in to out */
> +
> +    qemu_chr_fe_deinit(&be, true);
> +
> +    /* Check that out was written to */
> +    ret = g_file_get_contents(out, &contents, &length, NULL);
> +    g_assert(ret == TRUE);
> +    g_assert_cmpint(length, ==, 6);
> +    g_assert(strncmp(contents, "world!", 6) == 0);
> +    g_free(contents);
> +
> +    /* Check that in hasn't been modified */
> +    ret = g_file_get_contents(in, &contents, &length, NULL);
> +    g_assert(ret == TRUE);
> +    g_assert_cmpint(length, ==, 6);
> +    g_assert(strncmp(contents, "hello!", 6) == 0);
> +    g_stat(in, &file_stat);
> +    g_assert(file_stat.st_mtime == in_mtime);
> +
> +    g_free(contents);
> +    g_rmdir(tmp_path);
> +    g_free(tmp_path);
> +    g_free(in);
> +    g_free(out);
> +}
> +
>  static void char_file_test(void)
>  {
>      char_file_test_internal(NULL, NULL);
> @@ -1398,6 +1493,7 @@ int main(int argc, char **argv)
>      g_test_add_func("/char/pipe", char_pipe_test);
>  #endif
>      g_test_add_func("/char/file", char_file_test);
> +    g_test_add_func("/char/file/pathin", char_file_separate_input_file);
>  #ifndef _WIN32
>      g_test_add_func("/char/file-fifo", char_file_fifo_test);
>  #endif
> -- 
> 2.26.2

