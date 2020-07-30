Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44060C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F21B20829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZvWEbqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F21B20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19iS-0004o2-AH
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k19ht-0004Ix-50
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:38:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k19hr-00089N-EE
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596119930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBlHq20h2xXsrLyTWvnclaCPy3hBgDYHLZA3TR0/AD8=;
 b=FZvWEbqx+EbF8R/E60cgzK+soKvzwDSQWwWmPl2AHeHNyiYW6gRd7fu7vAGPRY2tu8XVMB
 Tp+v1UWSdmgSTRasKsAQBHxDhWTPdBtIg/l6I2jVJT1vc1ss1MHiDdQE6cfZCWX5y8eyRA
 9S5oAwUFcU04znFF9SRGi7qaW7O6bqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-IAbrcFqBMvGzztVb9tlBOA-1; Thu, 30 Jul 2020 10:38:46 -0400
X-MC-Unique: IAbrcFqBMvGzztVb9tlBOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6693100A614;
 Thu, 30 Jul 2020 14:38:44 +0000 (UTC)
Received: from [10.3.114.255] (ovpn-114-255.phx2.redhat.com [10.3.114.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 396221C6;
 Thu, 30 Jul 2020 14:38:44 +0000 (UTC)
Subject: Re: [PATCH 2/2] iotests/169: Test source cont with backing bmap
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200730120234.49288-1-mreitz@redhat.com>
 <20200730120234.49288-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2d89e3e6-a535-8d0c-63e2-605f7233d1bf@redhat.com>
Date: Thu, 30 Jul 2020 09:38:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730120234.49288-3-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 7:02 AM, Max Reitz wrote:
> Test migrating from a VM with a persistent bitmap in the backing chain,
> and then continuing that VM after the migration

Indeed, the more our iotest is like what libvirt actually does, the 
better we protect ourselves from future bugs in this area.

> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/169     | 64 +++++++++++++++++++++++++++++++++++++-
>   tests/qemu-iotests/169.out |  4 +--
>   2 files changed, 65 insertions(+), 3 deletions(-)
> 

> +class TestDirtyBitmapBackingMigration(iotests.QMPTestCase):
> +    def setUp(self):
> +        qemu_img_create('-f', iotests.imgfmt, base_a, size)
> +        qemu_img_create('-f', iotests.imgfmt, '-F', iotests.imgfmt,
> +                        '-b', base_a, disk_a, size)
> +
> +        for f in (disk_a, base_a):
> +            qemu_img('bitmap', '--add', f, 'bmap0')

I'm so glad to see 'qemu-img bitmap' getting some use :)

> +
> +        blockdev = {
> +            'node-name': 'node0',
> +            'driver': iotests.imgfmt,
> +            'file': {
> +                'driver': 'file',
> +                'filename': disk_a
> +            },
> +            'backing': {
> +                'node-name': 'node0-base',
> +                'driver': iotests.imgfmt,
> +                'file': {
> +                    'driver': 'file',
> +                    'filename': base_a
> +                }
> +            }
> +        }
> +
> +        self.vm = iotests.VM()
> +        self.vm.launch()
> +
> +        result = self.vm.qmp('blockdev-add', **blockdev)
> +        self.assert_qmp(result, 'return', {})
> +
> +        # Check that the bitmaps are there
> +        for node in self.vm.qmp('query-named-block-nodes', flat=True)['return']:
> +            if 'node0' in node['node-name']:

This caught me on the first read, before I realized it was a clever way 
to test both 'node0' and 'node0-base'.

> +                self.assert_qmp(node, 'dirty-bitmaps[0]/name', 'bmap0')
> +
> +        caps = [{'capability': 'events', 'state': True}]
> +        result = self.vm.qmp('migrate-set-capabilities', capabilities=caps)
> +        self.assert_qmp(result, 'return', {})
> +
> +    def tearDown(self):
> +        self.vm.shutdown()
> +        for f in (disk_a, base_a):
> +            os.remove(f)
> +
> +    def test_cont_on_source(self):
> +        """
> +        Continue the source after migration.
> +        """
> +        result = self.vm.qmp('migrate', uri=f'exec: cat > /dev/null')
> +        self.assert_qmp(result, 'return', {})
> +
> +        with Timeout(10, 'Migration timeout'):
> +            self.vm.wait_migration('postmigrate')
> +
> +        result = self.vm.qmp('cont')
> +        self.assert_qmp(result, 'return', {})
> +

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


