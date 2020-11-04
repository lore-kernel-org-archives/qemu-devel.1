Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075CBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC932083B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCh4AGs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC932083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNyS-0001sk-BI
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kaNsz-0001DW-NP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:51:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kaNsx-0003NG-GY
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+fiazxWBgPMH8Xt8M+tsmAE7iUnwmMpLZUGlyhpQt4=;
 b=CCh4AGs6x+P7cUgUBHnQP3EzvisP0Xh40qSTh1r4iel4uiJAjg37X3Pzy6JhwiI7swr9YC
 bn+A+kTqlDVvwI0dYMpyEcoWDa7d7XL4uLBJ4UAeHSmdulz34FdLSprGRqkiga6i0c8GEt
 1syM5edSdmWIYwexhayjzBGhcgy5kaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-fo5QzXCpOJKTYZDl8yjC4g-1; Wed, 04 Nov 2020 13:51:53 -0500
X-MC-Unique: fo5QzXCpOJKTYZDl8yjC4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F6A1101962B;
 Wed,  4 Nov 2020 18:51:51 +0000 (UTC)
Received: from starship (unknown [10.35.207.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE0685578A;
 Wed,  4 Nov 2020 18:51:47 +0000 (UTC)
Message-ID: <3c6b8cd2f4cbe7240e9956c3e1ee3eaf51715765.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: rewrite iotest 240 in python
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 04 Nov 2020 20:51:46 +0200
In-Reply-To: <be54a033-9672-052f-e45a-9d3322dd60a0@redhat.com>
References: <20201101161532.259609-1-mlevitsk@redhat.com>
 <20201101161532.259609-3-mlevitsk@redhat.com>
 <be54a033-9672-052f-e45a-9d3322dd60a0@redhat.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-11-03 at 13:53 +0100, Max Reitz wrote:
> On 01.11.20 17:15, Maxim Levitsky wrote:
> > The recent changes that brought RCU delayed device deletion,
> > broke few tests and this test breakage went unnoticed.
> > 
> > Fix this test by rewriting it in python
> > (which allows to wait for DEVICE_DELETED events before continuing).
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  tests/qemu-iotests/240     | 228 ++++++++++++++++---------------------
> >  tests/qemu-iotests/240.out |  76 ++++++++-----
> >  2 files changed, 143 insertions(+), 161 deletions(-)
> > 
> > diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
> > index 8b4337b58d..bfc9b72f36 100755
> > --- a/tests/qemu-iotests/240
> > +++ b/tests/qemu-iotests/240
> 
> [...]
> 
> > +class TestCase(iotests.QMPTestCase):
> > +    test_driver = "null-co"
> > +
> > +    def required_drivers(self):
> > +        return [self.test_driver]
> > +
> > +    @iotests.skip_if_unsupported(required_drivers)
> > +    def setUp(self):
> > +        self.vm = iotests.VM()
> > +        self.vm.launch()
> 
> It seems to me like all tests create a null-co block device.  The only
> difference is that test1() creates an R/W node, whereas all others
> create an RO node.  I don’t think that matters though, so maybe we can
> replace code duplication by creating the (RO) null-co node here.
> 
> Furthermore, we could also create two I/O threads and two accompanying
> virtio-scsi devices here (tests that don’t use them shouldn’t care)...
I agree with that, the test can be improved a lot. I on purpose didn't do
this since I wanted 1:1 translation of the bash test.
After that a refactoring, or a rewrite of this test can be very welcome.

> 
> > +
> > +    def tearDown(self):
> 
> ...and clean all of those up here.
> 
> > +        self.vm.shutdown()
> > +
> > +    def test1(self):
> > +        iotests.log('==Unplug a SCSI disk and then plug it again==')
> > +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0')
> > +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
> > +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0', filters = [iotests.filter_qmp_virtio_scsi])
> 
> A bit weird that you change your coding style for the @filters parameter
> (i.e., putting spaces around '='), and pylint thinks so, too.
It is a late change, which I copy&pasta'ed so no wonder it is a bit different.
Fixed!

That code too I would like later to move to a function or so.

> 
> > +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
> > +        self.vm.qmp_log('device_del', id='scsi-hd0')
> > +        self.vm.event_wait('DEVICE_DELETED')
> > +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
> > +        self.vm.qmp_log('device_del', id='scsi-hd0')
> > +        self.vm.event_wait('DEVICE_DELETED')
> > +        self.vm.qmp_log('device_del', id='scsi0')
> 
> I don’t think it makes a difference for this test, but perhaps it would
> be cleaner to wait for the DEVICE_DELETED event even for the virtio-scsi
> devices?

Actually this doesn't work since the whole thing is started with 'qtest' accel,
and there is no real guest there. 

The pcie device removal in 'production' happens only when you place the device on a 
pcie root port or on pci hotplug enabled bridge,
which then signals the removal of the device to the guest which needs to ACK this,
and only then the qemu actually removes the device and sends the DEVICE_DELETED event.

So this device_del is pretty much pointless I think, and it never will be really removed.
Again I tried to just translate the test without doing any more changes, but I will remove this.

> 
> > +        self.vm.qmp_log('blockdev-del', node_name='hd0')
> > +
> > +    def test2(self):
> > +        iotests.log('==Attach two SCSI disks using the same block device and the same iothread==')
> > +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
> > +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
> > +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0', filters = [iotests.filter_qmp_virtio_scsi])
> > +
> > +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
> > +        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0')
> > +        self.vm.qmp_log('device_del', id='scsi-hd1')
> > +        self.vm.event_wait('DEVICE_DELETED')
> > +        self.vm.qmp_log('device_del', id='scsi-hd0')
> > +        self.vm.event_wait('DEVICE_DELETED')
> 
> The bash version deleted them the other way around, but I suppose it
> doesn’t matter.  (It just made me wonder why you changed the order.)
I just didn't notice it since it didn't seem to be important.
> 
> > +        self.vm.qmp_log('device_del', id='scsi0')
> > +        self.vm.qmp_log('blockdev-del', node_name='hd0')
> > +
> > +    def test3(self):
> > +        iotests.log('==Attach two SCSI disks using the same block device but different iothreads==')
> > +
> > +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
> > +
> > +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
> > +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread1")
> > +
> > +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0', filters = [iotests.filter_qmp_virtio_scsi])
> > +        self.vm.qmp_log('device_add', id='scsi1', driver=iotests.get_virtio_scsi_device(), iothread='iothread1', filters = [iotests.filter_qmp_virtio_scsi])
> > +
> > +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0', bus="scsi0.0")
> > +        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0', bus="scsi1.0")
> > +
> > +        self.vm.qmp_log('device_del', id='scsi-hd0')
> > +        self.vm.event_wait('DEVICE_DELETED')
> > +        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0', bus="scsi1.0")
> > +
> > +        self.vm.qmp_log('device_del', id='scsi-hd1')
> > +        self.vm.event_wait('DEVICE_DELETED')
> > +
> > +        self.vm.qmp_log('device_del', id='scsi1')
> > +        self.vm.qmp_log('device_del', id='scsi0')
> > +
> > +        self.vm.qmp_log('blockdev-del', node_name='hd0')
> > +
> > +    def test4(self):
> > +        iotests.log('==Attach a SCSI disks using the same block device as a NBD server==')
> > +
> > +        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
> > +
> > +        self.vm.qmp_log('nbd-server-start',
> > +                        filters=[iotests.filter_qmp_testfiles],
> > +                        addr={'type':'unix', 'data':{'path':nbd_sock}})
> > +
> > +        self.vm.qmp_log('nbd-server-add', device='hd0')
> > +
> > +        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
> > +        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0', filters = [iotests.filter_qmp_virtio_scsi])
> > +        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
> > +
> > +
> > +if __name__ == '__main__':
> > +    if 'null-co' not in iotests.supported_formats():
> > +        iotests.notrun('null-co driver support missing')
> 
> I suppose it isn’t wrong to check this in two places (in the setUp()
> decorator, and then here again), but it doesn’t seem necessary either.
That is a result of a copy&pasta from some other iotest.
Fixed, thanks!


Thanks for the review!

Best regards,
	Maxim Levitsky

> 
> Max
> 
> > +    iotests.activate_logging()
> > +    iotests.main()



