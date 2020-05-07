Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B3FC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4AD208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UPwHnVMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4AD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWd0N-0007Sh-BS
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 05:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jWczX-00072U-Bm
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:38:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jWczV-0005CG-RE
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:38:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0479XaaV114218;
 Thu, 7 May 2020 09:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=qXh2384Rge9veRxP8YE1sCOU3s2RkTQtHf3wuv5p7Rg=;
 b=UPwHnVMKwR6NsZsYU1lbZclEStTe0Ex1/0wVukTOml365joUsnK420q5AwJeBMFQaA+r
 fhZHRlpE6rzgW8fEJHvl6LKfADk0EeQIPZOGyxwKRValS+GZjLIRYesCeFSLiU689kqO
 +zPB7YIiAvFjHSaNhp28xmM/feJiav676pkTzKCYQwli1HSGq9AJMp6//5HWs7RWBI4J
 vr1VvAExjW96kgBfHz8PLkVlHYMGmZ2K/CiseygzJdNTiSfd8+fJzfVl378dJoQLBJ0K
 M21T6sPX8/KyQyCkbNAnWDPCEA7M1DO6LmNBlruGtmjmdrhSFtGH+wCNrdqE7as3laU7 kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 30usgq67mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 May 2020 09:38:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0479arcK048090;
 Thu, 7 May 2020 09:38:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 30sjdxn26m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 May 2020 09:38:50 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0479cmEJ002321;
 Thu, 7 May 2020 09:38:48 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 07 May 2020 02:38:48 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 20C8C685536E; Thu,  7 May 2020 10:38:46 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] char-file: add test for distinct path= and pathin=
In-Reply-To: <20200507062442.15215-3-alxndr@bu.edu>
References: <20200507062442.15215-1-alxndr@bu.edu>
 <20200507062442.15215-3-alxndr@bu.edu>
Date: Thu, 07 May 2020 10:38:46 +0100
Message-ID: <m2mu6k6q55.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=59 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=59 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070077
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 05:38:52
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: berrange@redhat.com, marcandre.lureau@gmail.com, stefanha@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

For the most part this looks fine, but I wonder if maybe there should be
a couple more assertions to be certain that things are set up correctly
at first, as well as maybe being sure to confirm that things weren't
modified using stat().

See below...

On Thursday, 2020-05-07 at 02:24:42 -04, Alexander Bulekov wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/test-char.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/tests/test-char.c b/tests/test-char.c
> index 3afc9b1b8d..9b3e1e2a9b 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -1228,6 +1228,88 @@ static void char_file_test_internal(Chardev *ext_chr, const char *filepath)
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
> +    ret = qemu_chr_write_all(chr, buf, size);
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
> +
> +    in = g_build_filename(tmp_path, "in", NULL);
> +    out = g_build_filename(tmp_path, "out", NULL);
> +
> +    ret = g_file_set_contents(in, "hello!", 6, NULL);

Might be good to confirm that this worked here if we're expecting it to
be correct later.

> +
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

Similarly, maybe confirm here that chr is valid.

> +    main_loop(); /* should call file_read, and copy contents of in to out */
> +
> +    qemu_chr_fe_deinit(&be, true);
> +
> +    /* Check that contents of in were copied to out */
> +    ret = g_file_get_contents(out, &contents, &length, NULL);
> +    g_assert(ret == TRUE);
> +    g_assert_cmpint(length, ==, 6);
> +    g_assert(strncmp(contents, "hello!", 6) == 0);
> +    g_free(contents);
> +
> +    /* Check that in hasn't changed */
> +    ret = g_file_get_contents(in, &contents, &length, NULL);

While this tells us that the content is the same, it doesn't guarantee
that it wasn't modified - it might be worth doing a stat(), or g_stat(),
to ensure that the creation and modifications times are the same?
(Assuming that g_file_set_contents() will do that, or we compare a
before and after struct stat, if not)

I've seen cases in other things where the file was been re-written
exactly the same but only noticed because Vim told me it was externally
modified when I wasn't expecting it have been.

> +    g_assert(ret == TRUE);
> +    g_assert_cmpint(length, ==, 6);
> +    g_assert(strncmp(contents, "hello!", 6) == 0);
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
> @@ -1398,6 +1480,7 @@ int main(int argc, char **argv)
>      g_test_add_func("/char/pipe", char_pipe_test);
>  #endif
>      g_test_add_func("/char/file", char_file_test);
> +    g_test_add_func("/char/file/pathin", char_file_separate_input_file);
>  #ifndef _WIN32
>      g_test_add_func("/char/file-fifo", char_file_fifo_test);
>  #endif
> -- 
> 2.26.2

Thanks,

Darren.

