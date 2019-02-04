Received: from eggs.gnu.org ([209.51.188.92]:46144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gqdq8-0004ES-5J
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gqdq6-0008HK-EU
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:59:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gqdq6-0008Gs-6p
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:59:06 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-34-git-send-email-pbonzini@redhat.com>
	<6e8609da-a198-4457-afc2-88f911261994@redhat.com>
	<b925a626-dee7-a95f-2721-a821c6edf209@redhat.com>
	<469a90b3-c032-1373-01b2-9f29e49414c1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d6cadf7-46b0-1823-54e5-19b07bfca1a9@redhat.com>
Date: Mon, 4 Feb 2019 13:58:57 +0100
MIME-Version: 1.0
In-Reply-To: <469a90b3-c032-1373-01b2-9f29e49414c1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 33/52] build: switch to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>, thuth@redhat.com
Cc: qemu-devel@nongnu.org, yang.zhong@intel.com

On 01/02/19 15:56, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/31/19 11:15 PM, Paolo Bonzini wrote:
>> On 31/01/19 22:48, Philippe Mathieu-Daud=C3=A9 wrote:
>>> There is something I don't understand here: Does CONFIG_XEN in
>>> Kconfig.host take precedence over the target configs? I'm looking at
>>> these configs:
>>>
>>>  if supported_xen_target $target; then
>>>      echo "CONFIG_XEN=3Dn" >> $config_target_mak
>>>      if test "$xen_pci_passthrough" =3D yes; then
>>>          echo "CONFIG_XEN_PCI_PASSTHROUGH=3Dy" >> "$config_target_mak=
"
>>>      fi
>>>  fi
>>
>> You're right, Kconfig.host should contain CONFIG_XEN_BACKEND and not
>> CONFIG_XEN.
>=20
> Now when I disable Xen, exec.o isn't rebuilt, so I get link errors:
>=20
> /usr/bin/ld: exec.o: in function `reclaim_ramblock':
> qemu/exec.c:2392: undefined reference to `xen_invalidate_map_cache_entr=
y'
> /usr/bin/ld: exec.o: in function `qemu_ram_ptr_length':
> qemu/exec.c:2531: undefined reference to `xen_map_cache'
> /usr/bin/ld: exec.o: in function `qemu_map_ram_ptr':
> qemu/exec.c:2498: undefined reference to `xen_map_cache'
> /usr/bin/ld: exec.o: in function `qemu_ram_block_from_host':
> qemu/exec.c:2573: undefined reference to `xen_ram_addr_from_mapcache'
> /usr/bin/ld: exec.o: in function `address_space_unmap':
> qemu/exec.c:3699: undefined reference to `xen_invalidate_map_cache_entr=
y'
> /usr/bin/ld: exec.o: in function `address_space_cache_destroy':
> qemu/exec.c:3791: undefined reference to `xen_invalidate_map_cache_entr=
y'
> /usr/bin/ld: exec.o: in function `qemu_ram_ptr_length':
> qemu/exec.c:2528: undefined reference to `xen_map_cache'
> /usr/bin/ld: exec.o: in function `qemu_map_ram_ptr':
> qemu/exec.c:2495: undefined reference to `xen_map_cache'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:204: qemu-system-i386] Error 1
>=20
> Moving those function stubs into a real xen-stub.c file would be simple=
r
> from the buildsys PoV IMHO, but I also remember we prefer to avoid
> stubs, so not sure what's better here, neither what's wrong with make r=
ules.

Sorry, I don't understand.  Can you provide reproduction instructions?

Paolo
