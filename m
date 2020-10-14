Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABF6C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051F320878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="f0ffop4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051F320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSbJb-0006qy-P4
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kSbEY-0000cO-AZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:30:02 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:52232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kSbEN-0004Mz-0k
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:29:55 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id B0C6A2E15DE;
 Wed, 14 Oct 2020 10:29:43 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 ZetHEOcbWa-ThwuQY0V; Wed, 14 Oct 2020 10:29:43 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1602660583; bh=NJlYYzHx/SLIAArJE5urrYbPZJrSW7q9GSwvUKJ+1nI=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=f0ffop4yvoVH26FYm3ICGOjZqdkW1V5pGueKupNRqF//Vj49x10gM5u2KOob6jEAP
 4XsAfnJl9NvT+3hmrCzOxkWE/hInStO9jP5kUNSM4qaoDRZzoUjSX3dlLEjWkqQDFN
 Wl63sGr8iGUk/c98K8y5baGP5BjAZET96rzumPq8=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:6605::1:7])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 BdF3A9lb60-Thmu8uBS; Wed, 14 Oct 2020 10:29:43 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Wed, 14 Oct 2020 10:29:41 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v1 1/2] fuzz: add virtio-blk fuzz target
Message-ID: <20201014072931.GA5631@dimastep-nix>
References: <cover.1602078083.git.dimastep@yandex-team.ru>
 <0b922b854ac4121dd8574c3e9cd36c562f7d0a3c.1602078083.git.dimastep@yandex-team.ru>
 <20201013153052.qzq6dhatcbpx33au@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013153052.qzq6dhatcbpx33au@mozz.bu.edu>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=95.108.205.193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:29:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: stefanha@gmail.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 11:30:52AM -0400, Alexander Bulekov wrote:
> On 201007 1647, Dima Stepanov wrote:
> > The virtio-blk fuzz target sets up and fuzzes the available virtio-blk
> > queues. The implementation is based on two files:
> >   - tests/qtest/fuzz/virtio_scsi_fuzz.c
> >   - tests/qtest/virtio_blk_test.c
> > 
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > ---
> >  tests/qtest/fuzz/meson.build       |   1 +
> >  tests/qtest/fuzz/virtio_blk_fuzz.c | 234 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 235 insertions(+)
> >  create mode 100644 tests/qtest/fuzz/virtio_blk_fuzz.c
> > 
> > diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
> > index b31ace7..3b923dc 100644
> > --- a/tests/qtest/fuzz/meson.build
> > +++ b/tests/qtest/fuzz/meson.build
> > @@ -5,6 +5,7 @@ specific_fuzz_ss.add(files('fuzz.c', 'fork_fuzz.c', 'qos_fuzz.c',
> >  specific_fuzz_ss.add(when: 'CONFIG_I440FX', if_true: files('i440fx_fuzz.c'))
> >  specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio_net_fuzz.c'))
> >  specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuzz.c'))
> > +specific_fuzz_ss.add(files('virtio_blk_fuzz.c'))
> 
> Hi Dima,
> For consistency, maybe
> specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio_blk_fuzz.c'))
Good point, will update it.

> 
...
> > +
> > +static char *drive_create(void)
> > +{
> > +    int fd, ret;
> > +    char *t_path = g_strdup("/tmp/qtest.XXXXXX");
> > +
> > +    /* Create a temporary raw image */
> > +    fd = mkstemp(t_path);
> > +    g_assert_cmpint(fd, >=, 0);
> > +    ret = ftruncate(fd, TEST_IMAGE_SIZE);
> > +    g_assert_cmpint(ret, ==, 0);
> > +    close(fd);
> > +
> > +    g_test_queue_destroy(drive_destroy, t_path);
> > +    return t_path;
> > +}
> > +
> 
> I tested this out and it works with multi-process fuzzing under -jobs=4
> -workers=4 (this initialization happens after libfuzzer has already
> forked the processes). This seems like an interesting alternative to
> using fake null-co:// files. 
> I wonder if some state might leak as these disks are filled with fuzzer
> data.
Yes, i've also chosen between the fake null device and temporary file.
Tried this approach, just to see what will happen ). It seems to me that
slightly different paths can be triggered in this case and it is closer
to real usage.
But indeed, mb some state can leak, this is interesting.

> 
> Nit: these disk files remain after the fuzzer exists. It looks
> like the libfuzzer people suggest simply using atexit() to perform
> cleanup: https://reviews.llvm.org/D45762
> The is that the only way I have found to terminate the fuzzer is with
> SIGKILL, where atexit is skipped. QEMU installs some signal handlers in
> os-posix.c:os_setup_signal_handling to notify the main_loop that the
> qemu was killed. Since we replace qemu_main_loop by manually running
> main_loop_wait, we don't check main_loop_should_exit().
Got it! Thanks for sharing this is good to know ).

No other comments mixed in below.

Dima.
> 
> I sent a patch to disable QEMU's signal handlers for the fuzzer.
> Message-Id: <20201013152920.448335-1-alxndr@bu.edu>
> 
> With an atexit() call to clean up the temporary images:
> Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
> 
> > +static void *virtio_blk_test_setup(GString *cmd_line, void *arg)
> > +{
> > +    char *tmp_path = drive_create();
> > +
> > +    g_string_append_printf(cmd_line,
> > +                           " -drive if=none,id=drive0,file=%s,"
> > +                           "format=raw,auto-read-only=off ",
> > +                           tmp_path);
> > +
> > +    return arg;
> > +}
> > +
> > +static void register_virtio_blk_fuzz_targets(void)
> > +{
> > +    fuzz_add_qos_target(&(FuzzTarget){
> > +                .name = "virtio-blk-fuzz",
> > +                .description = "Fuzz the virtio-blk virtual queues, forking "
> > +                                "for each fuzz run",
> > +                .pre_vm_init = &counter_shm_init,
> > +                .pre_fuzz = &virtio_blk_pre_fuzz,
> > +                .fuzz = virtio_blk_fork_fuzz,},
> > +                "virtio-blk",
> > +                &(QOSGraphTestOptions){.before = virtio_blk_test_setup}
> > +                );
> > +
> > +    fuzz_add_qos_target(&(FuzzTarget){
> > +                .name = "virtio-blk-flags-fuzz",
> > +                .description = "Fuzz the virtio-blk virtual queues, forking "
> > +                "for each fuzz run (also fuzzes the virtio flags)",
> > +                .pre_vm_init = &counter_shm_init,
> > +                .pre_fuzz = &virtio_blk_pre_fuzz,
> > +                .fuzz = virtio_blk_with_flag_fuzz,},
> > +                "virtio-blk",
> > +                &(QOSGraphTestOptions){.before = virtio_blk_test_setup}
> > +                );
> > +}
> > +
> > +fuzz_target_init(register_virtio_blk_fuzz_targets);
> > -- 
> > 2.7.4
> > 

