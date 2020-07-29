Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C307C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435EC207F5
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="aLWCM92c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435EC207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ppp-0000GG-IC
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 13:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k0pp8-0008F8-BC
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:25:02 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:58003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k0pp6-0003xj-0G
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=QmeyV490Z7mAS7iFL6fIvV+ITrvU1gUOptIGxLZrfuM=; b=aLWCM92ck6tFuWJP0g+Gqwn4Wx
 jjI4E1ryiJv4A9sLARkZ1+SoMZlHdgrDANl5+eKYeEvcWdSaPgUMFp2T4bVO5Lno6l1J5CKqJyY6g
 n8RQMZvaUE9WcWC7EN65+ql4MS/tlo0kwEc7uL6A5pDG9MIMhxtEaUpRA1v1FPbZhyhc8AAQ9eEyJ
 gqHUOm/2NUx1prQ94ubXnWP4EZdHJ4MF/rj/+2T6xnv5Pd5l/XGkCx3d8D/qbzgqn0NHnYYqdStcP
 UV2lGOVK14YHAo0x7zpUnx89fW/7wWVTh1TqFDTB6GqS8Px9oHKzdcxs35ZlJ0+pa3ZChO3XyHkJd
 pA0j/faA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v8 1/7] tests/virtio-9p: added split readdir tests
Date: Wed, 29 Jul 2020 19:24:54 +0200
Message-ID: <1840276.exGcvpJF7P@silver>
In-Reply-To: <20200729174254.58aaccc6@bahia.lan>
References: <cover.1596012787.git.qemu_oss@crudebyte.com>
 <569b2e05ab1d0223b14a12dfbdf3ad5e8b3ac131.1596012787.git.qemu_oss@crudebyte.com>
 <20200729174254.58aaccc6@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 13:24:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mittwoch, 29. Juli 2020 17:42:54 CEST Greg Kurz wrote:
> On Wed, 29 Jul 2020 10:10:23 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > The previous, already existing 'basic' readdir test simply used a
> > 'count' parameter big enough to retrieve all directory entries with a
> > single Treaddir request.
> > 
> > In the 3 new 'split' readdir tests added by this patch, directory
> > entries are retrieved, split over several Treaddir requests by picking
> > small 'count' parameters which force the server to truncate the
> > response. So the test client sends as many Treaddir requests as
> > necessary to get all directory entries.
> > 
> > The following 3 new tests are added (executed in this sequence):
> > 
> > 1. Split readdir test with count=512
> > 2. Split readdir test with count=256
> > 3. Split readdir test with count=128
> > 
> > This test case sequence is chosen because the smaller the 'count' value,
> > the higher the chance of errors in case of implementation bugs on server
> > side.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> 
> The existing fs_readdir() function for the 'basic' test is a subset
> of the new fs_readdir_split() introduced by this patch (quite visible
> if you sdiff the code).
> 
> To avoid code duplication, I would have probably tried to do the changes
> in fs_readdir() and implement the 'basic' test as:
> 
> static void fs_readdir_basic(void *obj, void *data,
>                              QGuestAllocator *t_alloc)
> {
>     /*
>      * submit count = msize - 11, because 11 is the header size of Rreaddir
>      */
>     fs_readdir(obj, data, t_alloc, P9_MAX_SIZE - 11);
> }

You are right of course; there is code duplication. My thought was to preserve 
the simple readdir test code (at least at this initial stage) as it is really 
very simple and easy to understand.

The split readdir test code is probably already a tad more tedious to read.

I keep it in mind though and probably deduplicate this test code a bit later 
on. But I think it makes sense to start off with this version for now.

> but anyway this looks good to me so:
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks!

> >  tests/qtest/virtio-9p-test.c | 108 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 108 insertions(+)
> > 
> > diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> > index 2167322985..de30b717b6 100644
> > --- a/tests/qtest/virtio-9p-test.c
> > +++ b/tests/qtest/virtio-9p-test.c
> > @@ -578,6 +578,7 @@ static bool fs_dirents_contain_name(struct V9fsDirent
> > *e, const char* name)> 
> >      return false;
> >  
> >  }
> > 
> > +/* basic readdir test where reply fits into a single response message */
> > 
> >  static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
> >  {
> >  
> >      QVirtio9P *v9p = obj;
> > 
> > @@ -631,6 +632,89 @@ static void fs_readdir(void *obj, void *data,
> > QGuestAllocator *t_alloc)> 
> >      g_free(wnames[0]);
> >  
> >  }
> > 
> > +/* readdir test where overall request is split over several messages */
> > +static void fs_readdir_split(void *obj, void *data, QGuestAllocator
> > *t_alloc, +                             uint32_t count)
> > +{
> > +    QVirtio9P *v9p = obj;
> > +    alloc = t_alloc;
> > +    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DIR) };
> > +    uint16_t nqid;
> > +    v9fs_qid qid;
> > +    uint32_t nentries, npartialentries;
> > +    struct V9fsDirent *entries, *tail, *partialentries;
> > +    P9Req *req;
> > +    int fid;
> > +    uint64_t offset;
> > +
> > +    fs_attach(v9p, NULL, t_alloc);
> > +
> > +    fid = 1;
> > +    offset = 0;
> > +    entries = NULL;
> > +    nentries = 0;
> > +    tail = NULL;
> > +
> > +    req = v9fs_twalk(v9p, 0, fid, 1, wnames, 0);
> > +    v9fs_req_wait_for_reply(req, NULL);
> > +    v9fs_rwalk(req, &nqid, NULL);
> > +    g_assert_cmpint(nqid, ==, 1);
> > +
> > +    req = v9fs_tlopen(v9p, fid, O_DIRECTORY, 0);
> > +    v9fs_req_wait_for_reply(req, NULL);
> > +    v9fs_rlopen(req, &qid, NULL);
> > +
> > +    /*
> > +     * send as many Treaddir requests as required to get all directory
> > +     * entries
> > +     */
> > +    while (true) {
> > +        npartialentries = 0;
> > +        partialentries = NULL;
> > +
> > +        req = v9fs_treaddir(v9p, fid, offset, count, 0);
> > +        v9fs_req_wait_for_reply(req, NULL);
> > +        v9fs_rreaddir(req, &count, &npartialentries, &partialentries);
> > +        if (npartialentries > 0 && partialentries) {
> > +            if (!entries) {
> > +                entries = partialentries;
> > +                nentries = npartialentries;
> > +                tail = partialentries;
> > +            } else {
> > +                tail->next = partialentries;
> > +                nentries += npartialentries;
> > +            }
> > +            while (tail->next) {
> > +                tail = tail->next;
> > +            }
> > +            offset = tail->offset;
> > +        } else {
> > +            break;
> > +        }
> > +    }
> > +
> > +    g_assert_cmpint(
> > +        nentries, ==,
> > +        QTEST_V9FS_SYNTH_READDIR_NFILES + 2 /* "." and ".." */
> > +    );
> > +
> > +    /*
> > +     * Check all file names exist in returned entries, ignore their order
> > +     * though.
> > +     */
> > +    g_assert_cmpint(fs_dirents_contain_name(entries, "."), ==, true);
> > +    g_assert_cmpint(fs_dirents_contain_name(entries, ".."), ==, true);
> > +    for (int i = 0; i < QTEST_V9FS_SYNTH_READDIR_NFILES; ++i) {
> > +        char *name = g_strdup_printf(QTEST_V9FS_SYNTH_READDIR_FILE, i);
> > +        g_assert_cmpint(fs_dirents_contain_name(entries, name), ==,
> > true);
> > +        g_free(name);
> > +    }
> > +
> > +    v9fs_free_dirents(entries);
> > +
> > +    g_free(wnames[0]);
> > +}
> > +
> > 
> >  static void fs_walk_no_slash(void *obj, void *data, QGuestAllocator
> >  *t_alloc) {
> >  
> >      QVirtio9P *v9p = obj;
> > 
> > @@ -793,6 +877,24 @@ static void fs_flush_ignored(void *obj, void *data,
> > QGuestAllocator *t_alloc)> 
> >      g_free(wnames[0]);
> >  
> >  }
> > 
> > +static void fs_readdir_split_128(void *obj, void *data,
> > +                                 QGuestAllocator *t_alloc)
> > +{
> > +    fs_readdir_split(obj, data, t_alloc, 128);
> > +}
> > +
> > +static void fs_readdir_split_256(void *obj, void *data,
> > +                                 QGuestAllocator *t_alloc)
> > +{
> > +    fs_readdir_split(obj, data, t_alloc, 256);
> > +}
> > +
> > +static void fs_readdir_split_512(void *obj, void *data,
> > +                                 QGuestAllocator *t_alloc)
> > +{
> > +    fs_readdir_split(obj, data, t_alloc, 512);
> > +}
> > +
> > 
> >  static void register_virtio_9p_test(void)
> >  {
> >  
> >      qos_add_test("config", "virtio-9p", pci_config, NULL);
> > 
> > @@ -810,6 +912,12 @@ static void register_virtio_9p_test(void)
> > 
> >      qos_add_test("fs/flush/ignored", "virtio-9p", fs_flush_ignored,
> >      
> >                   NULL);
> >      
> >      qos_add_test("fs/readdir/basic", "virtio-9p", fs_readdir, NULL);
> > 
> > +    qos_add_test("fs/readdir/split_512", "virtio-9p",
> > +                 fs_readdir_split_512, NULL);
> > +    qos_add_test("fs/readdir/split_256", "virtio-9p",
> > +                 fs_readdir_split_256, NULL);
> > +    qos_add_test("fs/readdir/split_128", "virtio-9p",
> > +                 fs_readdir_split_128, NULL);
> > 
> >  }
> >  
> >  libqos_init(register_virtio_9p_test);




