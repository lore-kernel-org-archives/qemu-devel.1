Received: from eggs.gnu.org ([2001:4830:134:3::10]:55551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fK7ph-0002zm-Lb
	for qemu-devel@nongnu.org; Sat, 19 May 2018 15:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fK7pg-00071v-5a
	for qemu-devel@nongnu.org; Sat, 19 May 2018 15:48:01 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <531fdf40-e960-ff84-b061-22a43c8021c9@msgid.tls.msk.ru>
Date: Sat, 19 May 2018 22:47:45 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] megasas & scsi-disk - interesting I/O errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, "qemu-block@nongnu.org >> open list:Network Block Dev..." <qemu-block@nongnu.org>

Hello.

I've an interesting case here with megasas virtual device.

TL;DR see summary at the end.

Initially I were testing a backport of CVE-2017-9503 fix to
qemu 2.8.1 (which is in debian stable), and while testing I
found out that the last patch from the fix makes megasas-
attached storage device to be malfunctioning in windows10.
Copying files from it quite soon makes any I/O operation
to return "invalid parameter" error, with a lot of events
from "disk" subsystem in windows event log, like this:

Found an error at device \Device\Harddisk0\DR0 during page i/o request (t=
ranslated from ru, might be not exact)
Xml =D1=81=D0=BE=D0=B1=D1=8B=D1=82=D0=B8=D1=8F:
<Event xmlns=3D"http://schemas.microsoft.com/win/2004/08/events/event">
  <System>
    <Provider Name=3D"disk" />
    <EventID Qualifiers=3D"32772">51</EventID>
    <Level>3</Level>
    <Task>0</Task>
    <Keywords>0x80000000000000</Keywords>
    <TimeCreated SystemTime=3D"2018-05-19T16:06:59.339940000Z" />
    <EventRecordID>591</EventRecordID>
    <Channel>System</Channel>
    <Computer>DESKTOP-KEG4VT4</Computer>
    <Security />
  </System>
  <EventData>
    <Data>\Device\Harddisk0\DR0</Data>

<Binary>040080000100000000000000330004802D0100000E0000C000000000000000000=
000000000000000C300000000000000FFFFFFFF010000005800000800010000FD200A1282=
012040001000003C00000000A0838F88E4FFFFB899548F88E4FFFF0000000000000000C00=
7298E88E4FFFF0000000000000000A8F20000000000002A080000F2A80000080000000000=
0000000000000000000000000000000000000000000000000000</Binary>
  </EventData>

I enabled megasas tracing but weren't able to trigger the prob
when tracing is turned on. So I _guess_ it is timing-related, but
who knows.

Only the last patch in the CVE-2017-9503 patches triggers the
problem. Reverting it makes guest work just fine, with one
interesting issue: there are _still_ 2 errors logged like
that, followed by 2 warnings from ntfs telling us it can't
write journal data and the filesystem might become corrupt
(the same ntfs messages are logged with that patch applied,
too).  The patch in question is this one:

commit 87e459a810d7b1ec1638085b5a80ea3d9b43119a
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu Jun 1 17:26:14 2017 +0200

    megasas: always store SCSIRequest* into MegasasCmd

    This ensures that the request is unref'ed properly, and avoids a
    segmentation fault in the new qtest testcase that is added.
    This is CVE-2017-9503.

    Reported-by: Zhangyanyu <zyy4013@stu.ouc.edu.cn>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Now the more interesting stuff. I noticed that ubuntu also
applied the same CVE-2017-9503 fixes but on top of 2.8.0
version. So I tested their qemu and found out that it works.
So there's one change in 2.8.1 which "helps" to trigger the
error condition: it is this change:

commit 1f8af0d186abf9ef775a74d41bf2852ed8d59b63
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue Jan 3 18:20:28 2017 +0100

    scsi-block: fix direction of BYTCHK test for VERIFY commands

    The direction is wrong; scsi_block_is_passthrough returns
    false for commands that *can* use sglists.

    Reported-by: Zhang Qian <zhangqian@sangfor.com.cn>
    Fixes: 8fdc7839e40f43a426bc7e858cf1dbfe315a3804
    Cc: qemu-stable@nongnu.org
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2701,7 +2701,7 @@ static bool scsi_block_is_passthrough(SCSIDiskState=
 *s, uint8_t *buf)
          * for the number of logical blocks specified in the length
          * field).  For other modes, do not use scatter/gather operation=
.
          */
-        if ((buf[1] & 6) !=3D 2) {
+        if ((buf[1] & 6) =3D=3D 2) {
             return false;
         }
         break;

Reverting this one change from 2.8.1 makes the prob to go away
(with CVE-2017-9503 fixes applied).

Now the more interesting thing: this problem is also present in current
2.12.0 version and in all versions between 2.9 and 2.12...

To sum it all up:

2.8.0 + CVE-2017-9503 fix 87e459a810d =3D one or two i/o error
2.8.0 + CVE-2017-9503 fix 87e459a810d + 1f8af0d186abf9e =3D hdd unusable
up to current 2.12 =3D hdd unusable but depends on timings
up to current 2.12 with tracing =3D one or two i/o error

There's obviously something fishy going on here. I'd love to hear some
suggestions/hints about possible ways to debug this.

BTW, 2.12 is quite "stally", so to say, in various I/O operations, to
the point where working in win10 guest becomes almost impossible -
i/o stalls for 20..120 seconds every few minutes (cpu works, I can
move windows, spinners are spinning etc, until somethin else hits
i/o too). Besides that it is also generally slower.
I'll try to bisect that later.



Also while trying to find where the prob has been introduced I found out
an interesting pair of patches in this CVE-2017-9503 series.  See this
commit 36c327a69d723571f02a7691631667cdb1865ee1
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu Jun 1 17:23:13 2017 +0200

    megasas: do not read command more than once from frame

    Avoid TOC-TOU bugs by passing the frame_cmd down, and checking
    cmd->dcmd_opcode instead of cmd->frame->header.frame_cmd.

    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

around trace_megasas_handle_scsi call:

     trace_megasas_handle_scsi(mfi_frame_desc[cmd->frame->header.frame_cm=
d],
-                              is_logical, cmd->frame->header.target_id,
+    trace_megasas_handle_scsi(mfi_frame_desc[frame_cmd], is_logical,
+                              cmd->frame->header.target_id,
                               cmd->frame->header.lun_id, sdev, cmd->iov_=
size);

After applying this, we'll get:

     trace_megasas_handle_scsi(mfi_frame_desc[cmd->frame->header.frame_cm=
d],
     trace_megasas_handle_scsi(mfi_frame_desc[frame_cmd], is_logical,
                               cmd->frame->header.target_id,
                               cmd->frame->header.lun_id, sdev, cmd->iov_=
size);

which obviously wont compile.

Subsequent patch (b356807fcdfc45583c) fixes this.
But the thing is quite.. fun anyway.

Thanks!

/mjt
