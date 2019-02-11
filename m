Received: from eggs.gnu.org ([209.51.188.92]:46526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gtI4j-0005xG-EV
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gtHtz-0002nG-Pj
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:10:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gtHtz-0002mI-EP
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:10:03 -0500
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
	<1549897385-10091-3-git-send-email-liam.merwick@oracle.com>
	<13b4d86c-0af3-12b9-fce5-92f1eb0fe95d@redhat.com>
	<0251e2fc-3dbd-937a-0649-71fcd64e2d14@linux.ibm.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <0b53df4a-7065-b3b7-c419-3f8e55cffdfd@oracle.com>
Date: Mon, 11 Feb 2019 20:09:56 +0000
MIME-Version: 1.0
In-Reply-To: <0251e2fc-3dbd-937a-0649-71fcd64e2d14@linux.ibm.com>
Content-Type: multipart/mixed; boundary="------------3B022A67D582F5D0253E7C1F"
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tpm_tis: fix format string
 specifier in tpm_tis_show_buffer()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.ibm.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org

This is a multi-part message in MIME format.
--------------3B022A67D582F5D0253E7C1F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id x1BK8ii1149028

On 11/02/2019 19:56, Stefan Berger wrote:
> On 2/11/19 11:02 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Liam,
>>
>> On 2/11/19 4:03 PM, Liam Merwick wrote:
>>> cppcheck reports:
>>>
>>> [hw/tpm/tpm_tis.c:113]: (warning) %d in format string (no. 2)=20
>>> requires 'int' but the argument type is 'unsigned int'
>>>
>>> Fix this by using %u instead of %d
>=20
>=20
> Liam, Neither gcc nor cppcheck 1.86 complains about this on my system.=20
> What version of cppcheck are you using?

I was using 1.86 too but I had warnings enabled.

% cppcheck -j 8 --platform=3Dunix64 --force --inline-suppr=20
--enable=3Dwarning --error-exitcode=3D1 hw/tpm/tpm_tis.c
Checking hw/tpm/tpm_tis.c ...
[hw/tpm/tpm_tis.c:112]: (warning) %d in format string (no. 2) requires=20
'int' but the argument type is 'unsigned int'.


>=20
>=20
>>>
>>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>>> ---
>>> =C2=A0 hw/tpm/tpm_tis.c | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>>> index 860c2ace7d99..395500e8a61d 100644
>>> --- a/hw/tpm/tpm_tis.c
>>> +++ b/hw/tpm/tpm_tis.c
>>> @@ -110,7 +110,7 @@ static void tpm_tis_show_buffer(const unsigned=20
>>> char *buffer,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t len, i;
>> If you want to clean this, use a size_t here instead of u32.
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D MIN(tpm_cmd_get_size(buffer), =
buffer_size);
>>> -=C2=A0=C2=A0=C2=A0 printf("tpm_tis: %s length =3D %d\n", string, len=
);
>>> +=C2=A0=C2=A0=C2=A0 printf("tpm_tis: %s length =3D %u\n", string, len=
);
>> So here the format is '%zu'.
>> However in code cleanup we try go get ride of printf() calls and repla=
ce
>> them with trace points.
>=20
>=20
> This code is only used for debugging if DEBUG_TIS has been #defined. No=
=20
> need to add tracing here.

I'd come up the attached change (but that seems like overkill).

Regards,
Liam


>=20
>=20
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < len; i++) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i && !(i %=
 16)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 printf("\n");
>>>
>=20


--------------3B022A67D582F5D0253E7C1F
Content-Type: text/x-patch;
 name="v2-0003-tpm_tis-fix-format-string-specifier-in-tpm_tis_sh.patch"
Content-Disposition: attachment;
 filename*0="v2-0003-tpm_tis-fix-format-string-specifier-in-tpm_tis_sh.pa";
 filename*1="tch"
Content-Transfer-Encoding: 7bit

>From 5dc2333c009583f5ce7338d5d67f857a4e8f4c74 Mon Sep 17 00:00:00 2001
From: Liam Merwick <liam.merwick@oracle.com>
Date: Mon, 11 Feb 2019 13:15:17 +0000
Subject: [PATCH v2 3/3] tpm_tis: fix format string specifier in
 tpm_tis_show_buffer()

cppcheck reports:

[hw/tpm/tpm_tis.c:113]: (warning) %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'

Fix this by converting it, and the other calls to printf in
tpm_tis_show_buffer(), to use trace points.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/tpm/tpm_tis.c    | 11 ++++++-----
 hw/tpm/trace-events |  3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 860c2ace7d99..5d85b1cf61b1 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -107,17 +107,18 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
 static void tpm_tis_show_buffer(const unsigned char *buffer,
                                 size_t buffer_size, const char *string)
 {
-    uint32_t len, i;
+    size_t len;
+    uint32_t i;
 
     len = MIN(tpm_cmd_get_size(buffer), buffer_size);
-    printf("tpm_tis: %s length = %d\n", string, len);
+    trace_tpm_tis_show_buffer_hdr(string, len);
     for (i = 0; i < len; i++) {
         if (i && !(i % 16)) {
-            printf("\n");
+            trace_tpm_tis_show_buffer_newline();
         }
-        printf("%.2X ", buffer[i]);
+        trace_tpm_tis_show_buffer_entry(buffer[i]);
     }
-    printf("\n");
+    trace_tpm_tis_show_buffer_newline();
 }
 
 /*
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 920d32ad5514..41d99d489097 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -36,6 +36,9 @@ tpm_emulator_pre_save(void) ""
 tpm_emulator_inst_init(void) ""
 
 # hw/tpm/tpm_tis.c
+tpm_tis_show_buffer_hdr(const char *string, size_t buffer_size) ": %s length = %zu"
+tpm_tis_show_buffer_entry(const unsigned char entry) "%.2X "
+tpm_tis_show_buffer_newline(void) "\n"
 tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08x"
 tpm_tis_new_active_locality(uint8_t locty) "Active locality is now %d"
 tpm_tis_abort(uint8_t locty) "New active locality is %d"
-- 
1.8.3.1


--------------3B022A67D582F5D0253E7C1F--
