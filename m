Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCE3C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 20:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F53F2465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 20:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtThpKSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F53F2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuN3v-0004ja-Jl
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 15:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuN3G-0004D1-1Y
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 15:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuN3C-0004wE-N1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 15:56:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54884
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuN3C-0004vD-IF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 15:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579726593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wv4k85OYupHCvWdJ6Z3z2ncRM8EoEbBFSx/EtUIdHyk=;
 b=PtThpKSeJx6SX0zKw1GkQOqwADMAgoTyw/A/xmyLQHe2dTHJFOXFJORocxZILk+y9yveUA
 wa5AmZiDAKDrwJ2X8xu949x+LoV5jtJw4TToGuKhws5i3QpxWKtsG+EcOguodSPZRqrLPp
 YU9/gNkAkzZfAg1G/EGRafaw4Ix0260=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-OeJ6LMbLNrioEu4kT59bFw-1; Wed, 22 Jan 2020 15:56:32 -0500
Received: by mail-wr1-f72.google.com with SMTP id z10so561786wrt.21
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 12:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wv4k85OYupHCvWdJ6Z3z2ncRM8EoEbBFSx/EtUIdHyk=;
 b=iLZk+IACXMDMrXESXVSUZGeMCzJxl7oZvhpi3+3MGrd8X0knHH7WMYflSnwrbis5rH
 HunibDuj3tOASQ8dsk6rTsYgsoNf2QMMgUlQQsu28YplCE59z6+BNJuqbGGUmxO4D6+9
 KAUvc0D0jDRR+1QJydjwCxu+hc1kvE63EWUpjh7ivThC/MxQ/0q4aASo/RSI10F6/a4n
 aLWffasmdXPVeDaf1NwICh4tCv9hLcpDfMvcu1o82HyQ83mIeiT0xvw1SS6imNpw2MYl
 C8cZ31q1XA0+s1SAeVy7P5Hn2YwnXi5ppQMab0k9BoHANEnGtHJkTH30nC53RUoI28Wz
 DsGw==
X-Gm-Message-State: APjAAAUXnHkXCbHd61DbYiPxgqxhsC3Hu60hevyE21ctGL0fIgabK4d5
 izmL9gc/QNnxVhmR4MqodylxB4jG7jTcMpkpVBkxoyDkZUmJiv5HDc3Gi1CQw5YEx9VX8IeSlRS
 WUxw8bNnYoSACkqI=
X-Received: by 2002:a05:6000:12ce:: with SMTP id
 l14mr13788007wrx.342.1579726588791; 
 Wed, 22 Jan 2020 12:56:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1lM4DLqq1tVugmPQySyLpls5atHLcfqC4664iiUbypUlm6kWkbJ48xR9zPoEaa9etMnyG0Q==
X-Received: by 2002:a05:6000:12ce:: with SMTP id
 l14mr13787974wrx.342.1579726588512; 
 Wed, 22 Jan 2020 12:56:28 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id k11sm5569693wmc.20.2020.01.22.12.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 12:56:28 -0800 (PST)
Subject: Re: [PATCH v5 2/2] tests: add virtio-scsi and virtio-blk
 seg_max_adjust test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 ehabkost@redhat.com, mst@redhat.com, stefanha@redhat.com,
 Markus Armbruster <armbru@redhat.com>
References: <20191220140905.1718-1-dplotnikov@virtuozzo.com>
 <20191220140905.1718-3-dplotnikov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f36d9b80-68d5-016b-310d-44ae671ae68a@redhat.com>
Date: Wed, 22 Jan 2020 21:56:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220140905.1718-3-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: OeJ6LMbLNrioEu4kT59bFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, fam@euphon.net, Hannes Reinecke <hare@suse.com>,
 den@virtuozzo.com, mreitz@redhat.com, Cleber Rosa <crosa@redhat.com>,
 pbonzini@redhat.com, Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On 12/20/19 3:09 PM, Denis Plotnikov wrote:
> It tests proper seg_max_adjust settings for all machine types except
> 'none', 'isapc', 'microvm'
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   tests/acceptance/virtio_seg_max_adjust.py | 134 ++++++++++++++++++++++
>   1 file changed, 134 insertions(+)
>   create mode 100755 tests/acceptance/virtio_seg_max_adjust.py
> 
> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance/virtio_seg_max_adjust.py
> new file mode 100755
> index 0000000000..5458573138
> --- /dev/null
> +++ b/tests/acceptance/virtio_seg_max_adjust.py
> @@ -0,0 +1,134 @@
> +#!/usr/bin/env python
> +#
> +# Test virtio-scsi and virtio-blk queue settings for all machine types
> +#
> +# Copyright (c) 2019 Virtuozzo International GmbH
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +import sys
> +import os
> +import re
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
> +from qemu.machine import QEMUMachine
> +from avocado_qemu import Test
> +
> +#list of machine types and virtqueue properties to test
> +VIRTIO_SCSI_PROPS = {'seg_max_adjust': 'seg_max_adjust'}
> +VIRTIO_BLK_PROPS = {'seg_max_adjust': 'seg-max-adjust'}
> +
> +DEV_TYPES = {'virtio-scsi-pci': VIRTIO_SCSI_PROPS,
> +             'virtio-blk-pci': VIRTIO_BLK_PROPS}
> +
> +VM_DEV_PARAMS = {'virtio-scsi-pci': ['-device', 'virtio-scsi-pci,id=scsi0'],
> +                 'virtio-blk-pci': ['-device',
> +                                    'virtio-blk-pci,id=scsi0,drive=drive0',
> +                                    '-drive',
> +                                    'driver=null-co,id=drive0,if=none']}
> +
> +
> +class VirtioMaxSegSettingsCheck(Test):
> +    @staticmethod
> +    def make_pattern(props):
> +        pattern_items = ['{0} = \w+'.format(prop) for prop in props]
> +        return '|'.join(pattern_items)
> +
> +    def query_virtqueue(self, vm, dev_type_name):
> +        query_ok = False
> +        error = None
> +        props = None
> +
> +        output = vm.command('human-monitor-command',
> +                            command_line = 'info qtree')
> +        props_list = DEV_TYPES[dev_type_name].values();
> +        pattern = self.make_pattern(props_list)
> +        res = re.findall(pattern, output)
> +
> +        if len(res) != len(props_list):
> +            props_list = set(props_list)
> +            res = set(res)
> +            not_found = props_list.difference(res)
> +            not_found = ', '.join(not_found)
> +            error = '({0}): The following properties not found: {1}'\
> +                     .format(dev_type_name, not_found)
> +        else:
> +            query_ok = True
> +            props = dict()
> +            for prop in res:
> +                p = prop.split(' = ')
> +                props[p[0]] = p[1]
> +        return query_ok, props, error
> +
> +    def check_mt(self, mt, dev_type_name):
> +        with QEMUMachine(self.qemu_bin) as vm:
> +            vm.set_machine(mt["name"])
> +            for s in VM_DEV_PARAMS[dev_type_name]:
> +                vm.add_args(s)
> +            vm.launch()
> +            query_ok, props, error = self.query_virtqueue(vm, dev_type_name)
> +
> +        if not query_ok:
> +            self.fail('machine type {0}: {1}'.format(mt['name'], error))
> +
> +        for prop_name, prop_val in props.items():
> +            expected_val = mt[prop_name]
> +            self.assertEqual(expected_val, prop_val)
> +
> +    @staticmethod
> +    def seg_max_adjust_enabled(mt):
> +        # machine types >= 5.0 should have seg_max_adjust = true
> +        # others seg_max_adjust = false
> +        mt = mt.split("-")
> +
> +        # machine types with one line name and name like pc-x.x
> +        if len(mt) <= 2:
> +            return False
> +
> +        # machine types like pc-<chip_name>-x.x[.x]
> +        ver = mt[2]
> +        ver = ver.split(".");
> +
> +        # versions >= 5.0 goes with seg_max_adjust enabled
> +        major = int(ver[0])
> +
> +        if major >= 5:
> +            return True
> +        return False
> +
> +    def test_machine_types(self):
> +        # collect all machine types except 'none', 'isapc', 'microvm'
> +        with QEMUMachine(self.qemu_bin) as vm:
> +            vm.launch()
> +            machines = [m['name'] for m in vm.command('query-machines')]
> +            vm.shutdown()
> +        machines.remove('none')
> +        machines.remove('isapc')
> +        machines.remove('microvm')
> +
> +        for dev_type in DEV_TYPES:
> +            # create the list of machine types and their parameters.
> +            mtypes = list()
> +            for m in machines:
> +                if self.seg_max_adjust_enabled(m):
> +                    enabled = 'true'
> +                else:
> +                    enabled = 'false'
> +                mtypes.append({'name': m,
> +                               DEV_TYPES[dev_type]['seg_max_adjust']: enabled})
> +
> +            # test each machine type for a device type
> +            for mt in mtypes:
> +                self.check_mt(mt, dev_type)

This test is failing on OSX:

TestFail: machine type pc-i440fx-2.0: <class 'TypeError'>

Looking at my job-results/job-2020-01-22T17.54-92b7fae/job.log:

Unexpected error in object_property_find() at qom/object.c:1201:
qemu-system-x86_64: -device virtio-blk-pci,id=scsi0,drive=drive0: can't 
apply global virtio-blk-device.scsi=true: Property '.scsi' not found

Which makes sense looking at hw/block/virtio-blk.c:

1261 static Property virtio_blk_properties[] = {
1262     DEFINE_BLOCK_PROPERTIES(VirtIOBlock, conf.conf),
...
1268 #ifdef __linux__
1269     DEFINE_PROP_BIT64("scsi", VirtIOBlock, host_features,
1270                       VIRTIO_BLK_F_SCSI, false),
1271 #endif

Except code moved around, origin is:

$ git show 1063b8b15
commit 1063b8b15fb49fcf88ffa282b19aaaf7ca9c678c
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Apr 27 10:29:14 2009 +0200

     virtio-blk: add SGI_IO passthru support

     Add support for SG_IO passthru (packet commands) to the virtio-blk
     backend.  Conceptually based on an older patch from Hannes Reinecke
     but largely rewritten to match the code structure and layering in
     virtio-blk.

     Note that currently we issue the hose SG_IO synchronously.  We could
     easily switch to async I/O, but that would required either bloating
     the VirtIOBlockReq by the size of struct sg_io_hdr or an additional
     memory allocation for each SG_IO request.

I'm not sure what is the correct way to fix this.

Regards,

Phil.


