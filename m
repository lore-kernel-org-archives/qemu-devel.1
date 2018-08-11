Received: from eggs.gnu.org ([2001:4830:134:3::10]:50572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1foHKW-0004xc-DD
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 20:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1foHKS-00020s-8O
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 20:00:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1foHKR-0001xR-V1
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 20:00:24 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20180810095654.drs4fwswdakktqbw@sirius.home.kraxel.org>
Date: Sat, 11 Aug 2018 03:00:14 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC900BE8-12EB-4004-9AA4-A43A3A635C23@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
	<1533815202-11967-27-git-send-email-liran.alon@oracle.com>
	<20180810095654.drs4fwswdakktqbw@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH 26/29] vmsvga: Add basic support for
 display topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, Leonid Shatz <leonid.shatz@oracle.com>



> On 10 Aug 2018, at 12:56, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>  Hi,
>=20
>> +    case SVGA_REG_DISPLAY_WIDTH:
>> +        if ((s->display_id =3D=3D 0) || (s->display_id =3D=3D =
SVGA_ID_INVALID))
>> +            ret =3D s->new_width ? s->new_width : =
surface_width(surface);
>> +        else
>> +            ret =3D 0;
>> +        break;
>> +    case SVGA_REG_DISPLAY_HEIGHT:
>> +        if ((s->display_id =3D=3D 0) || (s->display_id =3D=3D =
SVGA_ID_INVALID))
>> +            ret =3D s->new_height ? s->new_height : =
surface_height(surface);
>> +        else
>> +            ret =3D 0;
>> +        break;
>=20
> What is the purpose of these registers?  Hint for the guest about the
> host display size?  If so you probably want wire up a callback for
> GraphicHwOps->ui_info.  This will be called on display changes (i.e.
> user resizes qemu gtk window).  See virtio_gpu_ui_info() for an =
example.
>=20
> cheers,
>  Gerd
>=20

These registers are suppose to indicate to guest the display monitor =
size (width & height).

When the QEMU console framework timer will run =
gui_update()->dpy_refresh()->VNC =
dpy_refresh()->graphics_hw_update()->VMware-SVGA gfx_update()
Then vmsvga_update_display()->vmsvga_check_size() makes sure that host =
display surface is set to have width/height as specified in =
vmsvga_state_s->{new_width, new_height}.
Therefore, if new_width have been set, then host display will be changed =
to the value set by the guest.

Thus, wiring up GraphicsHwOps->ui_info callback to return new info on =
SVGA_REG_DISPLAY_{WIDTH, HEIGHT} registers may be useful only for case =
that we want guest to respond to the fact that the host display have =
been resized. However, I am not sure there is a mechanism to notify =
guest from vmware-svga device that this even has occurred for guest to =
reread these registers. Both in Linux vmware-svga driver code and VMware =
SVGA development kit, the SVGA_IRQFLAG_* flags don=E2=80=99t indicate =
such an interrupt source. In addition, it seems that Linux vmware-svga =
driver code only reads these registers at vmw_kms_save_vga() which =
weirdly enough, seems to be unreachable code (not called from =
anywhere=E2=80=A6).
Therefore, I=E2=80=99m not sure it is important to do this change at =
this patch series.

But I am not 100% familiar with the entire QEMU graphics stack so maybe =
I=E2=80=99m missing something trivial here.

Regards,
-Liran
