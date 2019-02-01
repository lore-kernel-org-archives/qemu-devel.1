Received: from eggs.gnu.org ([209.51.188.92]:40457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpaFG-0004MX-L9
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpaFC-0006cf-Fi
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:56:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpaF3-0006Wh-C6
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:56:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so7417376wrt.4
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 06:56:22 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-34-git-send-email-pbonzini@redhat.com>
	<6e8609da-a198-4457-afc2-88f911261994@redhat.com>
	<b925a626-dee7-a95f-2721-a821c6edf209@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <469a90b3-c032-1373-01b2-9f29e49414c1@redhat.com>
Date: Fri, 1 Feb 2019 15:56:19 +0100
MIME-Version: 1.0
In-Reply-To: <b925a626-dee7-a95f-2721-a821c6edf209@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 33/52] build: switch to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>, thuth@redhat.com
Cc: qemu-devel@nongnu.org, yang.zhong@intel.com

On 1/31/19 11:15 PM, Paolo Bonzini wrote:
> On 31/01/19 22:48, Philippe Mathieu-Daudé wrote:
>> There is something I don't understand here: Does CONFIG_XEN in
>> Kconfig.host take precedence over the target configs? I'm looking at
>> these configs:
>>
>>  if supported_xen_target $target; then
>>      echo "CONFIG_XEN=n" >> $config_target_mak
>>      if test "$xen_pci_passthrough" = yes; then
>>          echo "CONFIG_XEN_PCI_PASSTHROUGH=y" >> "$config_target_mak"
>>      fi
>>  fi
> 
> You're right, Kconfig.host should contain CONFIG_XEN_BACKEND and not
> CONFIG_XEN.

Now when I disable Xen, exec.o isn't rebuilt, so I get link errors:

/usr/bin/ld: exec.o: in function `reclaim_ramblock':
qemu/exec.c:2392: undefined reference to `xen_invalidate_map_cache_entry'
/usr/bin/ld: exec.o: in function `qemu_ram_ptr_length':
qemu/exec.c:2531: undefined reference to `xen_map_cache'
/usr/bin/ld: exec.o: in function `qemu_map_ram_ptr':
qemu/exec.c:2498: undefined reference to `xen_map_cache'
/usr/bin/ld: exec.o: in function `qemu_ram_block_from_host':
qemu/exec.c:2573: undefined reference to `xen_ram_addr_from_mapcache'
/usr/bin/ld: exec.o: in function `address_space_unmap':
qemu/exec.c:3699: undefined reference to `xen_invalidate_map_cache_entry'
/usr/bin/ld: exec.o: in function `address_space_cache_destroy':
qemu/exec.c:3791: undefined reference to `xen_invalidate_map_cache_entry'
/usr/bin/ld: exec.o: in function `qemu_ram_ptr_length':
qemu/exec.c:2528: undefined reference to `xen_map_cache'
/usr/bin/ld: exec.o: in function `qemu_map_ram_ptr':
qemu/exec.c:2495: undefined reference to `xen_map_cache'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:204: qemu-system-i386] Error 1

Moving those function stubs into a real xen-stub.c file would be simpler
from the buildsys PoV IMHO, but I also remember we prefer to avoid
stubs, so not sure what's better here, neither what's wrong with make rules.
