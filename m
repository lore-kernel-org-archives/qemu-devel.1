Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049B3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 12:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F322068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 12:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYKZXk/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F322068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg5tt-0005Du-0x
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 08:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jg5t2-0004Gr-Iz
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 08:19:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jg5t0-0005dI-CC
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 08:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591100357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sw4YhN9g0A3TJMSvmj5qqQIe4IPeur4bVbwb118GHGo=;
 b=RYKZXk/x/4UyioqQjdDhF5TDBTsPTXEF0s/WSercFrtHeifU390Muz7qR45LXqLB69kxUs
 yRZ3S6WpM4oX6t5y+YdpkI4toQWmpIkgQ3iYZyFpASU6mYow8vCPgWp8Lhf42xxQ9jyO9Q
 /+0ROea1mj9JNron70Kb9vWXtjqj2C8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-eZAaSz3uNauRa0C5Aqvr1g-1; Tue, 02 Jun 2020 08:19:13 -0400
X-MC-Unique: eZAaSz3uNauRa0C5Aqvr1g-1
Received: by mail-wr1-f72.google.com with SMTP id m14so1322329wrj.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 05:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=sw4YhN9g0A3TJMSvmj5qqQIe4IPeur4bVbwb118GHGo=;
 b=pkK8na9Yc+n8TIy9VXLKDOCYgC+sTwCOE4vJbXCcsHWBr08WpIjwtLofMjajsBae8h
 Cbbp1XAW4yEuAL5AdN0KlXqplIpHnb2ofHAvdxpZeZSn8ryZcBIjvh3l3trZ95vWN43i
 Adz/CTmJ6Jch17fQBp059f87PnvnAYeqLQXHxqLz/betXWiskWkEDdR8rY1MUKNzEK4s
 kvx/3SD2smslYeHIjArMzfYeUiq0Y4AcozDf0WqY372y5ycOt+KiZOnkjCfU1orDSoMt
 6xnKVl3DoRJ9ZkC3nZRfO+bStfuc0feXuKqU6T0ixeoyEEo7uizzHRkWdhoLZZ1DNNKO
 /Lig==
X-Gm-Message-State: AOAM53320bePkn8r7aNnyThTi0e+R8uQ4UYwGgQybjMNzpjueKasMZLl
 OaQ7KvLWwbr8pUzUjbxhbaS9r0Zgpxpy5ML79aQcFZNG/RivY6jozD4kzgm/fBs0pSUyx6jeQOl
 oyxiXQ67xcyOq9FU=
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr3871060wmk.35.1591100350720; 
 Tue, 02 Jun 2020 05:19:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY8yPcRAh2UfUczeiPg0TL1qC0agWMTnRmVo+2Q3Y8pwqfwy2ON7O+/DWr3t0A3plh4cQFTQ==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr3871031wmk.35.1591100350249; 
 Tue, 02 Jun 2020 05:19:10 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y80sm3548613wmc.34.2020.06.02.05.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 05:19:09 -0700 (PDT)
Subject: Re: [PATCH 3/5] colo: Introduce high-level test suite
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1589199922.git.lukasstraub2@web.de>
 <9ebbc340436b2b60c27bdb1fc5d47734d9854514.1589199922.git.lukasstraub2@web.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <fa2f9239-a1f0-0c38-0d1e-1fee77a28811@redhat.com>
Date: Tue, 2 Jun 2020 14:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9ebbc340436b2b60c27bdb1fc5d47734d9854514.1589199922.git.lukasstraub2@web.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 22:14:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01,
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
Cc: Zhang Chen <chen.zhang@intel.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Cleber/Wainer

On 5/11/20 2:27 PM, Lukas Straub wrote:
> Add high-level test relying on the colo resource-agent to test
> all failover cases while checking guest network connectivity.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  scripts/colo-resource-agent/crm_master   |  44 ++
>  scripts/colo-resource-agent/crm_resource |  12 +
>  tests/acceptance/colo.py                 | 689 +++++++++++++++++++++++
>  3 files changed, 745 insertions(+)
>  create mode 100755 scripts/colo-resource-agent/crm_master
>  create mode 100755 scripts/colo-resource-agent/crm_resource
>  create mode 100644 tests/acceptance/colo.py
> 
> diff --git a/scripts/colo-resource-agent/crm_master b/scripts/colo-resource-agent/crm_master
> new file mode 100755
> index 0000000000..886f523bda
> --- /dev/null
> +++ b/scripts/colo-resource-agent/crm_master
> @@ -0,0 +1,44 @@
> +#!/bin/bash
> +
> +# Fake crm_master for COLO testing
> +#
> +# Copyright (c) Lukas Straub <lukasstraub2@web.de>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +TMPDIR="$HA_RSCTMP"
> +score=0
> +query=0
> +
> +OPTIND=1
> +while getopts 'Qql:Dv:N:G' opt; do
> +    case "$opt" in
> +        Q|q)
> +            # Noop
> +        ;;
> +        "l")
> +            # Noop
> +        ;;
> +        "D")
> +            score=0
> +        ;;
> +        "v")
> +            score=$OPTARG
> +        ;;
> +        "N")
> +            TMPDIR="$COLO_TEST_REMOTE_TMP"
> +        ;;
> +        "G")
> +            query=1
> +        ;;
> +    esac
> +done
> +
> +if (( query )); then
> +    cat "${TMPDIR}/master_score" || exit 1
> +else
> +    echo $score > "${TMPDIR}/master_score" || exit 1
> +fi
> +
> +exit 0
> diff --git a/scripts/colo-resource-agent/crm_resource b/scripts/colo-resource-agent/crm_resource
> new file mode 100755
> index 0000000000..ad69ff3c6b
> --- /dev/null
> +++ b/scripts/colo-resource-agent/crm_resource
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +
> +# Fake crm_resource for COLO testing
> +#
> +# Copyright (c) Lukas Straub <lukasstraub2@web.de>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +# Noop
> +
> +exit 0
> diff --git a/tests/acceptance/colo.py b/tests/acceptance/colo.py
> new file mode 100644
> index 0000000000..465513fb6c
> --- /dev/null
> +++ b/tests/acceptance/colo.py
> @@ -0,0 +1,689 @@
> +# High-level test suite for qemu COLO testing all failover cases while checking
> +# guest network connectivity
> +#
> +# Copyright (c) Lukas Straub <lukasstraub2@web.de>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +# HOWTO:
> +#
> +# This test has the following parameters:
> +# bridge_name: name of the bridge interface to connect qemu to
> +# host_address: ip address of the bridge interface
> +# guest_address: ip address that the guest gets from the dhcp server
> +# bridge_helper: path to the brige helper
> +#                (default: /usr/lib/qemu/qemu-bridge-helper)
> +# install_cmd: command to run to install iperf3 and memtester in the guest
> +#              (default: "sudo -n dnf -q -y install iperf3 memtester")
> +#
> +# To run the network tests, you have to specify the parameters.
> +#
> +# Example for running the colo tests:
> +# make check-acceptance FEDORA_31_ARCHES="x86_64" AVOCADO_TAGS="-t colo \
> +#  -p bridge_name=br0 -p host_address=192.168.220.1 \
> +#  -p guest_address=192.168.220.222"
> +#
> +# The colo tests currently only use x86_64 test vm images. With the
> +# FEDORA_31_ARCHES make variable as in the example, only the x86_64 images will
> +# be downloaded.
> +#
> +# If you're running the network tests as an unprivileged user, you need to set
> +# the suid bit on the bridge helper (chmod +s <bridge-helper>).
> +#
> +# The dhcp server should assign a static ip to the guest, else the test may be
> +# unreliable. The Mac address for the guest is always 52:54:00:12:34:56.
> +
> +
> +import select
> +import sys
> +import subprocess
> +import shutil
> +import os
> +import signal
> +import os.path
> +import time
> +import tempfile
> +
> +from avocado import Test
> +from avocado import skipUnless
> +from avocado.utils import network
> +from avocado.utils import vmimage
> +from avocado.utils import cloudinit
> +from avocado.utils import ssh
> +from avocado.utils.path import find_command
> +
> +from avocado_qemu import pick_default_qemu_bin, BUILD_DIR, SOURCE_DIR
> +from qemu.qmp import QEMUMonitorProtocol
> +
> +def iperf3_available():
> +    try:
> +        find_command("iperf3")
> +    except CmdNotFoundError:
> +        return False
> +    return True
> +
> +class ColoTest(Test):
> +
> +    # Constants
> +    OCF_SUCCESS = 0
> +    OCF_ERR_GENERIC = 1
> +    OCF_ERR_ARGS = 2
> +    OCF_ERR_UNIMPLEMENTED = 3
> +    OCF_ERR_PERM = 4
> +    OCF_ERR_INSTALLED = 5
> +    OCF_ERR_CONFIGURED = 6
> +    OCF_NOT_RUNNING = 7
> +    OCF_RUNNING_MASTER = 8
> +    OCF_FAILED_MASTER = 9
> +
> +    HOSTA = 10
> +    HOSTB = 11
> +
> +    QEMU_OPTIONS = (" -display none -vga none -enable-kvm"
> +                    " -smp 2 -cpu host -m 768"
> +                    " -device e1000,mac=52:54:00:12:34:56,netdev=hn0"
> +                    " -device virtio-blk,drive=colo-disk0")
> +
> +    FEDORA_VERSION = "31"
> +    IMAGE_CHECKSUM = "e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0"
> +    IMAGE_SIZE = "4294967296b"
> +
> +    hang_qemu = False
> +    checkpoint_failover = False
> +    traffic_procs = []
> +
> +    def get_image(self, temp_dir):
> +        try:
> +            return vmimage.get(
> +                "fedora", arch="x86_64", version=self.FEDORA_VERSION,
> +                checksum=self.IMAGE_CHECKSUM, algorithm="sha256",
> +                cache_dir=self.cache_dirs[0],
> +                snapshot_dir=temp_dir)
> +        except:
> +            self.cancel("Failed to download/prepare image")
> +
> +    @skipUnless(ssh.SSH_CLIENT_BINARY, "No SSH client available")
> +    def setUp(self):
> +        # Qemu and qemu-img binary
> +        default_qemu_bin = pick_default_qemu_bin()
> +        self.QEMU_BINARY = self.params.get("qemu_bin", default=default_qemu_bin)
> +
> +        # If qemu-img has been built, use it, otherwise the system wide one
> +        # will be used.  If none is available, the test will cancel.
> +        qemu_img = os.path.join(BUILD_DIR, "qemu-img")
> +        if not os.path.exists(qemu_img):
> +            qemu_img = find_command("qemu-img", False)
> +        if qemu_img is False:
> +            self.cancel("Could not find \"qemu-img\", which is required to "
> +                        "create the bootable image")
> +        self.QEMU_IMG_BINARY = qemu_img

Probably worth refactoring that as re-usable pick_qemuimg_bin() or
better named?

Similarly with BRIDGE_HELPER... We need a generic class to get binaries
from environment or build dir.

> +        vmimage.QEMU_IMG = qemu_img
> +
> +        self.RESOURCE_AGENT = os.path.join(SOURCE_DIR,
> +                                           "scripts/colo-resource-agent/colo")
> +        self.ADD_PATH = os.path.join(SOURCE_DIR, "scripts/colo-resource-agent")
> +
> +        # Logs
> +        self.RA_LOG = os.path.join(self.outputdir, "resource-agent.log")
> +        self.HOSTA_LOGDIR = os.path.join(self.outputdir, "hosta")
> +        self.HOSTB_LOGDIR = os.path.join(self.outputdir, "hostb")
> +        os.makedirs(self.HOSTA_LOGDIR)
> +        os.makedirs(self.HOSTB_LOGDIR)
> +
> +        # Temporary directories
> +        # We don't use self.workdir because of unix socket path length
> +        # limitations
> +        self.TMPDIR = tempfile.mkdtemp()
> +        self.TMPA = os.path.join(self.TMPDIR, "hosta")
> +        self.TMPB = os.path.join(self.TMPDIR, "hostb")
> +        os.makedirs(self.TMPA)
> +        os.makedirs(self.TMPB)
> +
> +        # Network
> +        self.BRIDGE_NAME = self.params.get("bridge_name")
> +        if self.BRIDGE_NAME:
> +            self.HOST_ADDRESS = self.params.get("host_address")
> +            self.GUEST_ADDRESS = self.params.get("guest_address")
> +            self.BRIDGE_HELPER = self.params.get("bridge_helper",
> +                                    default="/usr/lib/qemu/qemu-bridge-helper")
> +            self.SSH_PORT = 22
> +        else:
> +            # QEMU's hard coded usermode router address
> +            self.HOST_ADDRESS = "10.0.2.2"
> +            self.GUEST_ADDRESS = "127.0.0.1"
> +            self.BRIDGE_HOSTA_PORT = network.find_free_port(address="127.0.0.1")
> +            self.BRIDGE_HOSTB_PORT = network.find_free_port(address="127.0.0.1")
> +            self.SSH_PORT = network.find_free_port(address="127.0.0.1")
> +
> +        self.CLOUDINIT_HOME_PORT = network.find_free_port()
> +
> +        # Find free port range
> +        base_port = 1024
> +        while True:
> +            base_port = network.find_free_port(start_port=base_port,
> +                                               address="127.0.0.1")
> +            if base_port == None:
> +                self.cancel("Failed to find a free port")
> +            for n in range(base_port, base_port +4):
> +                if n > 65535:
> +                    break
> +                if not network.is_port_free(n, "127.0.0.1"):
> +                    break
> +            else:
> +                # for loop above didn't break
> +                break
> +
> +        self.BASE_PORT = base_port
> +
> +        # Disk images
> +        self.log.info("Downloading/preparing boot image")
> +        self.HOSTA_IMAGE = self.get_image(self.TMPA).path
> +        self.HOSTB_IMAGE = self.get_image(self.TMPB).path
> +        self.CLOUDINIT_ISO = os.path.join(self.TMPDIR, "cloudinit.iso")
> +
> +        self.log.info("Preparing cloudinit image")
> +        try:
> +            cloudinit.iso(self.CLOUDINIT_ISO, self.name,
> +                          username="test", password="password",
> +                          phone_home_host=self.HOST_ADDRESS,
> +                          phone_home_port=self.CLOUDINIT_HOME_PORT)
> +        except Exception as e:
> +            self.cancel("Failed to prepare cloudinit image")
> +
> +        self.QEMU_OPTIONS += " -cdrom %s" % self.CLOUDINIT_ISO
> +
> +        # Network bridge
> +        if not self.BRIDGE_NAME:
> +            self.BRIDGE_PIDFILE = os.path.join(self.TMPDIR, "bridge.pid")
> +            self.run_command(("'%s' -pidfile '%s'"
> +                " -M none -display none -daemonize"
> +                " -netdev user,id=host,hostfwd=tcp:127.0.0.1:%s-:22"
> +                " -netdev socket,id=hosta,listen=127.0.0.1:%s"
> +                " -netdev socket,id=hostb,listen=127.0.0.1:%s"
> +                " -netdev hubport,id=hostport,hubid=0,netdev=host"
> +                " -netdev hubport,id=porta,hubid=0,netdev=hosta"
> +                " -netdev hubport,id=portb,hubid=0,netdev=hostb")
> +                % (self.QEMU_BINARY, self.BRIDGE_PIDFILE, self.SSH_PORT,
> +                   self.BRIDGE_HOSTA_PORT, self.BRIDGE_HOSTB_PORT), 0)
> +
> +    def tearDown(self):
> +        try:
> +            pid = self.read_pidfile(self.BRIDGE_PIDFILE)
> +            if pid and self.check_pid(pid):
> +                os.kill(pid, signal.SIGKILL)
> +        except Exception as e:
> +            pass
> +
> +        try:
> +            self.ra_stop(self.HOSTA)
> +        except Exception as e:
> +            pass
> +
> +        try:
> +            self.ra_stop(self.HOSTB)
> +        except Exception as e:
> +            pass
> +
> +        try:
> +            self.ssh_close()
> +        except Exception as e:
> +            pass
> +
> +        for proc in self.traffic_procs:
> +            try:
> +                os.killpg(proc.pid, signal.SIGTERM)
> +            except Exception as e:
> +                pass
> +
> +        shutil.rmtree(self.TMPDIR)
> +
> +    def run_command(self, cmdline, expected_status, env=None):
> +        proc = subprocess.Popen(cmdline, shell=True, stdout=subprocess.PIPE,
> +                                stderr=subprocess.STDOUT,
> +                                universal_newlines=True, env=env)
> +        stdout, stderr = proc.communicate()
> +        if proc.returncode != expected_status:
> +            self.fail("command \"%s\" failed with code %s:\n%s"
> +                           % (cmdline, proc.returncode, stdout))
> +
> +        return proc.returncode
> +
> +    def cat_line(self, path):
> +        line=""
> +        try:
> +            fd = open(path, "r")
> +            line = str.strip(fd.readline())
> +            fd.close()
> +        except:
> +            pass
> +        return line
> +
> +    def read_pidfile(self, pidfile):
> +        try:
> +            pid = int(self.cat_line(pidfile))
> +        except ValueError:
> +            return None
> +        else:
> +            return pid
> +
> +    def check_pid(self, pid):
> +        try:
> +            os.kill(pid, 0)
> +        except OSError:
> +            return False
> +        else:
> +            return True
> +
> +    def ssh_open(self):
> +        self.ssh_conn = ssh.Session(self.GUEST_ADDRESS, self.SSH_PORT,
> +                                    user="test", password="password")
> +        self.ssh_conn.DEFAULT_OPTIONS += (("UserKnownHostsFile", "/dev/null"),)
> +        for i in range(10):
> +            try:
> +                if self.ssh_conn.connect():
> +                    return
> +            except Exception as e:
> +                pass
> +            time.sleep(4)
> +        self.fail("sshd timeout")
> +
> +    def ssh_ping(self):
> +        if self.ssh_conn.cmd("echo ping").stdout != b"ping\n":
> +            self.fail("ssh ping failed")
> +
> +    def ssh_close(self):
> +        self.ssh_conn.quit()
> +
> +    def setup_base_env(self, host):
> +        PATH = os.getenv("PATH", "")
> +        env = { "PATH": "%s:%s" % (self.ADD_PATH, PATH),
> +                "HA_LOGFILE": self.RA_LOG,
> +                "OCF_RESOURCE_INSTANCE": "colo-test",
> +                "OCF_RESKEY_CRM_meta_clone_max": "2",
> +                "OCF_RESKEY_CRM_meta_notify": "true",
> +                "OCF_RESKEY_CRM_meta_timeout": "30000",
> +                "OCF_RESKEY_qemu_binary": self.QEMU_BINARY,
> +                "OCF_RESKEY_qemu_img_binary": self.QEMU_IMG_BINARY,
> +                "OCF_RESKEY_disk_size": str(self.IMAGE_SIZE),

We can remove IMAGE_SIZE and use a runtime filesize(HOSTA_IMAGE) instead.

> +                "OCF_RESKEY_checkpoint_interval": "10000",
> +                "OCF_RESKEY_base_port": str(self.BASE_PORT),
> +                "OCF_RESKEY_debug": "2"}
> +
> +        if host == self.HOSTA:
> +            env.update({"OCF_RESKEY_options":
> +                            ("%s -qmp unix:%s,server,nowait"
> +                             " -drive if=none,id=parent0,file='%s'")
> +                            % (self.QEMU_OPTIONS, self.get_qmp_sock(host),
> +                               self.HOSTA_IMAGE),
> +                        "OCF_RESKEY_active_hidden_dir": self.TMPA,
> +                        "OCF_RESKEY_listen_address": "127.0.0.1",
> +                        "OCF_RESKEY_log_dir": self.HOSTA_LOGDIR,
> +                        "OCF_RESKEY_CRM_meta_on_node": "127.0.0.1",
> +                        "HA_RSCTMP": self.TMPA,
> +                        "COLO_TEST_REMOTE_TMP": self.TMPB})
> +
> +        else:
> +            env.update({"OCF_RESKEY_options":
> +                            ("%s -qmp unix:%s,server,nowait"
> +                             " -drive if=none,id=parent0,file='%s'")
> +                            % (self.QEMU_OPTIONS, self.get_qmp_sock(host),
> +                               self.HOSTB_IMAGE),
> +                        "OCF_RESKEY_active_hidden_dir": self.TMPB,
> +                        "OCF_RESKEY_listen_address": "127.0.0.2",
> +                        "OCF_RESKEY_log_dir": self.HOSTB_LOGDIR,
> +                        "OCF_RESKEY_CRM_meta_on_node": "127.0.0.2",
> +                        "HA_RSCTMP": self.TMPB,
> +                        "COLO_TEST_REMOTE_TMP": self.TMPA})
> +
> +        if self.BRIDGE_NAME:
> +            env["OCF_RESKEY_options"] += \
> +                " -netdev bridge,id=hn0,br=%s,helper='%s'" \
> +                % (self.BRIDGE_NAME, self.BRIDGE_HELPER)
> +        else:
> +            if host == self.HOSTA:
> +                env["OCF_RESKEY_options"] += \
> +                    " -netdev socket,id=hn0,connect=127.0.0.1:%s" \
> +                    % self.BRIDGE_HOSTA_PORT
> +            else:
> +                env["OCF_RESKEY_options"] += \
> +                    " -netdev socket,id=hn0,connect=127.0.0.1:%s" \
> +                    % self.BRIDGE_HOSTB_PORT
> +        return env
> +
> +    def ra_start(self, host):
> +        env = self.setup_base_env(host)
> +        self.run_command(self.RESOURCE_AGENT + " start", self.OCF_SUCCESS, env)
> +
> +    def ra_stop(self, host):
> +        env = self.setup_base_env(host)
> +        self.run_command(self.RESOURCE_AGENT + " stop", self.OCF_SUCCESS, env)
> +
> +    def ra_monitor(self, host, expected_status):
> +        env = self.setup_base_env(host)
> +        self.run_command(self.RESOURCE_AGENT + " monitor", expected_status, env)
> +
> +    def ra_promote(self, host):
> +        env = self.setup_base_env(host)
> +        self.run_command(self.RESOURCE_AGENT + " promote", self.OCF_SUCCESS,env)
> +
> +    def ra_notify_start(self, host):
> +        env = self.setup_base_env(host)
> +
> +        env.update({"OCF_RESKEY_CRM_meta_notify_type": "post",
> +                    "OCF_RESKEY_CRM_meta_notify_operation": "start"})
> +
> +        if host == self.HOSTA:
> +            env.update({"OCF_RESKEY_CRM_meta_notify_master_uname": "127.0.0.1",
> +                        "OCF_RESKEY_CRM_meta_notify_start_uname": "127.0.0.2"})
> +        else:
> +            env.update({"OCF_RESKEY_CRM_meta_notify_master_uname": "127.0.0.2",
> +                        "OCF_RESKEY_CRM_meta_notify_start_uname": "127.0.0.1"})
> +
> +        self.run_command(self.RESOURCE_AGENT + " notify", self.OCF_SUCCESS, env)
> +
> +    def ra_notify_stop(self, host):
> +        env = self.setup_base_env(host)
> +
> +        env.update({"OCF_RESKEY_CRM_meta_notify_type": "pre",
> +                    "OCF_RESKEY_CRM_meta_notify_operation": "stop"})
> +
> +        if host == self.HOSTA:
> +            env.update({"OCF_RESKEY_CRM_meta_notify_master_uname": "127.0.0.1",
> +                        "OCF_RESKEY_CRM_meta_notify_stop_uname": "127.0.0.2"})
> +        else:
> +            env.update({"OCF_RESKEY_CRM_meta_notify_master_uname": "127.0.0.2",
> +                        "OCF_RESKEY_CRM_meta_notify_stop_uname": "127.0.0.1"})
> +
> +        self.run_command(self.RESOURCE_AGENT + " notify", self.OCF_SUCCESS, env)
> +
> +    def get_pid(self, host):
> +        if host == self.HOSTA:
> +            return self.read_pidfile(os.path.join(self.TMPA,
> +                                                 "colo-test-qemu.pid"))
> +        else:
> +            return self.read_pidfile(os.path.join(self.TMPB,
> +                                                 "colo-test-qemu.pid"))
> +
> +    def get_master_score(self, host):
> +        if host == self.HOSTA:
> +            return int(self.cat_line(os.path.join(self.TMPA, "master_score")))
> +        else:
> +            return int(self.cat_line(os.path.join(self.TMPB, "master_score")))
> +
> +    def get_qmp_sock(self, host):
> +        if host == self.HOSTA:
> +            return os.path.join(self.TMPA, "my-qmp.sock")
> +        else:
> +            return os.path.join(self.TMPB, "my-qmp.sock")
> +
> +
> +    def kill_qemu_pre(self, host):
> +        pid = self.get_pid(host)
> +
> +        qmp_sock = self.get_qmp_sock(host)
> +
> +        if self.checkpoint_failover:
> +            qmp_conn = QEMUMonitorProtocol(qmp_sock)
> +            qmp_conn.settimeout(10)
> +            qmp_conn.connect()
> +            while True:
> +                event = qmp_conn.pull_event(wait=True)
> +                if event["event"] == "STOP":
> +                    break
> +            qmp_conn.close()
> +
> +
> +        if pid and self.check_pid(pid):
> +            if self.hang_qemu:
> +                os.kill(pid, signal.SIGSTOP)
> +            else:
> +                os.kill(pid, signal.SIGKILL)
> +                while self.check_pid(pid):
> +                    time.sleep(1)
> +
> +    def kill_qemu_post(self, host):
> +        pid = self.get_pid(host)
> +
> +        if self.hang_qemu and pid and self.check_pid(pid):
> +            os.kill(pid, signal.SIGKILL)
> +            while self.check_pid(pid):
> +                time.sleep(1)
> +
> +    def prepare_guest(self):
> +        pass
> +
> +    def cycle_start(self, cycle):
> +        pass
> +
> +    def active_section(self):
> +        return False
> +
> +    def cycle_end(self, cycle):
> +        pass
> +
> +    def check_connection(self):
> +        self.ssh_ping()
> +        for proc in self.traffic_procs:
> +            if proc.poll() != None:
> +                self.fail("Traffic process died")
> +
> +    def _test_colo(self, loop=1):
> +        loop = max(loop, 1)
> +        self.log.info("Will put logs in %s" % self.outputdir)
> +
> +        self.ra_stop(self.HOSTA)
> +        self.ra_stop(self.HOSTB)
> +
> +        self.log.info("*** Startup ***")
> +        self.ra_start(self.HOSTA)
> +        self.ra_start(self.HOSTB)
> +
> +        self.ra_monitor(self.HOSTA, self.OCF_SUCCESS)
> +        self.ra_monitor(self.HOSTB, self.OCF_SUCCESS)
> +
> +        self.log.info("*** Promoting ***")
> +        self.ra_promote(self.HOSTA)
> +        cloudinit.wait_for_phone_home(("0.0.0.0", self.CLOUDINIT_HOME_PORT),
> +                                      self.name)
> +        self.ssh_open()
> +        self.prepare_guest()
> +
> +        self.ra_notify_start(self.HOSTA)
> +
> +        while self.get_master_score(self.HOSTB) != 100:
> +            self.ra_monitor(self.HOSTA, self.OCF_RUNNING_MASTER)
> +            self.ra_monitor(self.HOSTB, self.OCF_SUCCESS)
> +            time.sleep(1)
> +
> +        self.log.info("*** Replication started ***")
> +
> +        self.check_connection()
> +
> +        primary = self.HOSTA
> +        secondary = self.HOSTB
> +
> +        for n in range(loop):
> +            self.cycle_start(n)
> +            self.log.info("*** Secondary failover ***")
> +            self.kill_qemu_pre(primary)
> +            self.ra_notify_stop(secondary)
> +            self.ra_monitor(secondary, self.OCF_SUCCESS)
> +            self.ra_promote(secondary)
> +            self.ra_monitor(secondary, self.OCF_RUNNING_MASTER)
> +            self.kill_qemu_post(primary)
> +
> +            self.check_connection()
> +
> +            tmp = primary
> +            primary = secondary
> +            secondary = tmp
> +
> +            self.log.info("*** Secondary continue replication ***")
> +            self.ra_start(secondary)
> +            self.ra_notify_start(primary)
> +
> +            self.check_connection()
> +
> +            # Wait for resync
> +            while self.get_master_score(secondary) != 100:
> +                self.ra_monitor(primary, self.OCF_RUNNING_MASTER)
> +                self.ra_monitor(secondary, self.OCF_SUCCESS)
> +                time.sleep(1)
> +
> +            self.log.info("*** Replication started ***")
> +
> +            self.check_connection()
> +
> +            if self.active_section():
> +                break
> +
> +            self.log.info("*** Primary failover ***")
> +            self.kill_qemu_pre(secondary)
> +            self.ra_monitor(primary, self.OCF_RUNNING_MASTER)
> +            self.ra_notify_stop(primary)
> +            self.ra_monitor(primary, self.OCF_RUNNING_MASTER)
> +            self.kill_qemu_post(secondary)
> +
> +            self.check_connection()
> +
> +            self.log.info("*** Primary continue replication ***")
> +            self.ra_start(secondary)
> +            self.ra_notify_start(primary)
> +
> +            self.check_connection()
> +
> +            # Wait for resync
> +            while self.get_master_score(secondary) != 100:
> +                self.ra_monitor(primary, self.OCF_RUNNING_MASTER)
> +                self.ra_monitor(secondary, self.OCF_SUCCESS)
> +                time.sleep(1)
> +
> +            self.log.info("*** Replication started ***")
> +
> +            self.check_connection()
> +
> +            self.cycle_end(n)

Interesting test :)

> +
> +        self.ssh_close()
> +
> +        self.ra_stop(self.HOSTA)
> +        self.ra_stop(self.HOSTB)
> +
> +        self.ra_monitor(self.HOSTA, self.OCF_NOT_RUNNING)
> +        self.ra_monitor(self.HOSTB, self.OCF_NOT_RUNNING)
> +        self.log.info("*** all ok ***")
> +
> +
> +class ColoQuickTest(ColoTest):
> +    """
> +    :avocado: tags=colo
> +    :avocado: tags=quick
> +    :avocado: tags=arch:x86_64
> +    """
> +
> +    timeout = 300
> +
> +    def cycle_end(self, cycle):
> +        self.log.info("Testing with peer qemu hanging"
> +                      " and failover during checkpoint")
> +        self.hang_qemu = True
> +
> +    def test_quick(self):
> +        self.checkpoint_failover = True
> +        self.log.info("Testing with peer qemu crashing"
> +                      " and failover during checkpoint")
> +        self._test_colo(loop=2)
> +
> +
> +class ColoNetworkTest(ColoTest):
> +
> +    def prepare_guest(self):
> +        install_cmd = self.params.get("install_cmd", default=
> +                                "sudo -n dnf -q -y install iperf3 memtester")
> +        self.ssh_conn.cmd(install_cmd)
> +        # Use two instances to work around a bug in iperf3
> +        self.ssh_conn.cmd("iperf3 -sD; iperf3 -sD -p 5202")
> +
> +    def _cycle_start(self, cycle):
> +        pass
> +
> +    def cycle_start(self, cycle):
> +        self._cycle_start(cycle)
> +        tests = [("", "client-to-server tcp"), ("-R", "server-to-client tcp")]
> +
> +        self.log.info("Testing iperf %s" % tests[cycle % 2][1])
> +        iperf_cmd = "iperf3 %s -t 60 -i 60 --connect-timeout 30000 -c %s" \
> +                        % (tests[cycle % 2][0], self.GUEST_ADDRESS)
> +        proc = subprocess.Popen("while %s && %s; do sleep 1; done >>'%s' 2>&1"
> +                    % (iperf_cmd, iperf_cmd + " -p 5202",
> +                    os.path.join(self.outputdir, "iperf.log")),
> +                    shell=True, preexec_fn=os.setsid, stdin=subprocess.DEVNULL,
> +                    stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

So this run on the host, require the host to be Linux + iperf3
installed. Don't we need to be privileged to run it?

> +        self.traffic_procs.append(proc)
> +        time.sleep(5) # Wait for iperf to get up to speed
> +
> +    def cycle_end(self, cycle):
> +        for proc in self.traffic_procs:
> +            try:
> +                os.killpg(proc.pid, signal.SIGTERM)
> +                proc.wait()
> +            except Exception as e:
> +                pass
> +        self.traffic_procs.clear()
> +        time.sleep(20)
> +
> +class ColoRealNetworkTest(ColoNetworkTest):
> +    """
> +    :avocado: tags=colo
> +    :avocado: tags=slow
> +    :avocado: tags=network_test
> +    :avocado: tags=arch:x86_64
> +    """
> +
> +    timeout = 900
> +
> +    def active_section(self):
> +        time.sleep(300)
> +        return False
> +
> +    @skipUnless(iperf3_available(), "iperf3 not available")
> +    def test_network(self):
> +        if not self.BRIDGE_NAME:
> +            self.cancel("bridge options not given, will skip network test")
> +        self.log.info("Testing with peer qemu crashing and network load")
> +        self._test_colo(loop=2)
> +
> +class ColoStressTest(ColoNetworkTest):
> +    """
> +    :avocado: tags=colo
> +    :avocado: tags=slow
> +    :avocado: tags=stress_test
> +    :avocado: tags=arch:x86_64
> +    """
> +
> +    timeout = 1800

How long does this test take on your hw (what CPU, to compare)?

> +
> +    def _cycle_start(self, cycle):
> +        if cycle == 4:
> +            self.log.info("Stresstest with peer qemu hanging, network load"
> +                          " and failover during checkpoint")
> +            self.checkpoint_failover = True
> +            self.hang_qemu = True
> +        elif cycle == 8:
> +            self.log.info("Stresstest with peer qemu crashing and network load")
> +            self.checkpoint_failover = False
> +            self.hang_qemu = False
> +        elif cycle == 12:
> +            self.log.info("Stresstest with peer qemu hanging and network load")
> +            self.checkpoint_failover = False
> +            self.hang_qemu = True
> +
> +    @skipUnless(iperf3_available(), "iperf3 not available")
> +    def test_stress(self):
> +        if not self.BRIDGE_NAME:
> +            self.cancel("bridge options not given, will skip network test")
> +        self.log.info("Stresstest with peer qemu crashing, network load"
> +                      " and failover during checkpoint")
> +        self.checkpoint_failover = True
> +        self._test_colo(loop=16)
> 


