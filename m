Received: from eggs.gnu.org ([2001:4830:134:3::10]:58580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Alan.Robinson@ts.fujitsu.com>) id 1emHHW-0005Tz-KD
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Alan.Robinson@ts.fujitsu.com>) id 1emHHR-0004RY-LN
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:00:50 -0500
Date: Thu, 15 Feb 2018 12:00:16 +0100
Message-ID: <20180215110016.GB23170@ts.fujitsu.com>
Reply-To: Alan.Robinson@ts.fujitsu.com
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-31-f4bug@amsat.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <20180215042900.16078-31-f4bug@amsat.org>
From: Alan.Robinson@ts.fujitsu.com (Alan Robinson)
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 30/30] xen: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Thu, Feb 15, 2018 at 01:29:00AM -0300, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Subject: [Xen-devel] [PATCH 30/30] xen: use the BYTE-based definitions
> List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
>=20
> It ease code review, unit is explicit.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/block/xen_disk.c        |  4 ++--
>  hw/xenpv/xen_domainbuild.c | 10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index f74fcd42d1..557005b5e5 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -1153,9 +1153,9 @@ static int blk_connect(struct XenDevice *xendev)
>      }
> =20
>      xen_pv_printf(xendev, 1, "type \"%s\", fileproto \"%s\", filename \"=
%s\","
> -                  " size %" PRId64 " (%" PRId64 " MB)\n",
> +                  " size %" PRId64 " (%llu MB)\n",
>                    blkdev->type, blkdev->fileproto, blkdev->filename,
> -                  blkdev->file_size, blkdev->file_size >> 20);
> +                  blkdev->file_size, blkdev->file_size / M_BYTE);
> =20
>      /* Fill in number of sector size and number of sectors */
>      xenstore_write_be_int(&blkdev->xendev, "sector-size", blkdev->file_b=
lk);
> diff --git a/hw/xenpv/xen_domainbuild.c b/hw/xenpv/xen_domainbuild.c
> index 027f76fad1..083fb80ee5 100644
> --- a/hw/xenpv/xen_domainbuild.c
> +++ b/hw/xenpv/xen_domainbuild.c
> @@ -75,9 +75,9 @@ int xenstore_domain_init1(const char *kernel, const cha=
r *ramdisk,
>      xenstore_write_str(dom, "vm",     vm);
> =20
>      /* memory */
> -    xenstore_write_int(dom, "memory/target", ram_size >> 10);  // kB
> -    xenstore_write_int(vm, "memory",         ram_size >> 20);  // MB
> -    xenstore_write_int(vm, "maxmem",         ram_size >> 20);  // MB
> +    xenstore_write_int(dom, "memory/target", ram_size * K_BYTE);
> +    xenstore_write_int(vm, "memory",         ram_size * M_BYTE);
> +    xenstore_write_int(vm, "maxmem",         ram_size * M_BYTE);

These changes looks wrong, surely it must be 'ram_size / K_BYTE'...

Alan


--cmJC7u66zC7hs+87
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIKTgYJKoZIhvcNAQcCoIIKPzCCCjsCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
CH8wggSjMIIDi6ADAgECAgo2C52zAAAAAlTDMA0GCSqGSIb3DQEBBQUAMC8xLTArBgNVBAMT
JEZ1aml0c3UgVGVjaG5vbG9neSBTb2x1dGlvbnMgVXNlciBDQTAeFw0xNzA1MTIxNTM0Mjda
Fw0xOTAzMTExMjI0NTlaMEAxFzAVBgNVBAMMDlJvYmluc29uLCBBbGFuMSUwIwYDVQQKDBxG
dWppdHN1IFRlY2hub2xvZ3kgU29sdXRpb25zMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKB
gQClZEMpN68qHzred2QKqifLuUSlYnt/kB4V9Kjy8U7cQK/pN+ytbEBFXsllMyP2CjgGNYFu
oqeztgkla2vBrjV9ilrJe3s+RJqkXgioKG1RSuiDW0sBFvI90dS4mHCH7cOTPPFHO5QHuCBU
bClqAN0HlKweu/rIbqg0/g9j+SMb8QIDAQABo4ICMjCCAi4wCwYDVR0PBAQDAgWgMIGSBgNV
HREEgYowgYeBHGFsYW4ucm9iaW5zb25AdHMuZnVqaXRzdS5jb22BJmFsYW4ucm9iaW5zb25A
ZW1laWFjZW1lYS5mdWppdHN1LmxvY2FsgRxhbGFuLnJvYmluc29uQGNlbWFpbC5mc2MubmV0
gSFBbGFuLlJvYmluc29uQGZ1aml0c3Utc2llbWVucy5jb20wHQYDVR0OBBYEFIlosAD8kas+
gZn51OiifJoSRQTUMB8GA1UdIwQYMBaAFAj1yGq/gON7UMQ59AeYRuhtfpeoMDwGA1UdHwQ1
MDMwMaAvoC2GK2h0dHA6Ly9jZHAudHMuZnVqaXRzdS5jb20vY2RwL2Z0czAxdXNlci5jcmww
RwYIKwYBBQUHAQEEOzA5MDcGCCsGAQUFBzAChitodHRwOi8vYWlhLnRzLmZ1aml0c3UuY29t
L2FpYS9mdHMwMXVzZXIuY2VyMAwGA1UdEwEB/wQCMAAwPQYJKwYBBAGCNxUHBDAwLgYmKwYB
BAGCNxUIhYXEMoGH/2GBhYEEhuyCIIHHgRp5g4igcYfS8S8CAWQCAQgwEwYDVR0lBAwwCgYI
KwYBBQUHAwQwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDBEBgkqhkiG9w0BCQ8ENzA1
MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcw
DQYJKoZIhvcNAQEFBQADggEBADwUZHvoZuxiGLFQCoURq/FgeKSyxKrjuoutb8Bs3blR2QDA
D3NWp0W+T4Js9fDcIb3Rq3uvFx0T/EcUiz1fFeQyN4B2xT8ofAnZeWuxWxWLUqS/K73fRIUC
m7DUNj8lgRGsnSnAIl6ZKHDrdvwnxrF7qFPRVz77B4k3BK5mkMxxNVtKjbCoPj8fnh17Vnob
Wnb0yztrPYeOHi2CqIey5qPjVMSTxKJYOejwjvE78SBMKKQS7cHBg+iOnYK90S0m+LK2/Yz5
vgJtjGJL+68d5i0O/rmzgefOEeuMtD0IOI9lFXoUS16hbxj8gMy0dXKxfPhoYWB7bqIlY4Ri
mpguPFwwggPUMIICvKADAgECAhA0zRJXyDaDRuC/9z0wA24FMA0GCSqGSIb3DQEBBQUAMC8x
LTArBgNVBAMTJEZ1aml0c3UgVGVjaG5vbG9neSBTb2x1dGlvbnMgUm9vdCBDQTAeFw0wOTAz
MTIxMjI0NTlaFw0xOTAzMTExMjI0NTlaMC8xLTArBgNVBAMTJEZ1aml0c3UgVGVjaG5vbG9n
eSBTb2x1dGlvbnMgVXNlciBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALAb
TX9HzfBJFvcukKqEBkui1MHs3p1dgZw8zkXRmp7pEbaRs2DAD3cosLZadP8zjWvowiRs5F+I
mAo07Iib8dNUj0TWduHx2hRl6SQV+ffaumRdIrLvodWiGrNbX8ggWpQGyii7zYCLkI514XX3
1ZOL0rgcrTtzhnFC7SdvpWFUhL8cxrfYk0sE+UZxLyqUdIjgvvf1DVTojyvVws+bu24N4noT
+YA/r+brt2CEcFf+YMnewGT3HJE32D/xmXMm3AF3xJeZ2/22Ykix3mRI8TDDPGGahSoR/ccp
iHY5HESuzSdo/Dg+9PEBb+G+G5ntZhxn040m8W9ZzqFE7DbbIWcCAwEAAaOB6zCB6DAdBgNV
HQ4EFgQUCPXIar+A43tQxDn0B5hG6G1+l6gwCwYDVR0PBAQDAgGGMB8GA1UdIwQYMBaAFBR1
4le2FTcVgCqX5VFIZazPhpDLMBIGA1UdEwEB/wQIMAYBAf8CAQAwRwYIKwYBBQUHAQEEOzA5
MDcGCCsGAQUFBzAChitodHRwOi8vYWlhLnRzLmZ1aml0c3UuY29tL2FpYS9mdHMwMXJvb3Qu
Y2VyMDwGA1UdHwQ1MDMwMaAvoC2GK2h0dHA6Ly9jZHAudHMuZnVqaXRzdS5jb20vY2RwL2Z0
czAxcm9vdC5jcmwwDQYJKoZIhvcNAQEFBQADggEBAEO6UD/S8PW3J7dQ4b1eVFm9c5pwAkqO
p+sfm7qXJEM5a392iex0GYoGbmgmpPnXsS9fCPOojQwziQQbK89A3A+Fz7M3C01Hs6qhpQMi
G74gauZsAxwFgQPRddRkcei3axzCjXRz8AFsgt6+qr+BjugPs9eilGRUj+JL7mjeWByOPNU+
xRcRJp7ZMpaYZ3V/upkNTQAQKTDIV9GjeXVYTwDAD/JxDSdYRpPNSBvIM5KBwz0qCwrX3wJz
YWAKob6wztsm12//cfkn9w0LswYN4aQdciTNyvH6EGkt7k6RSE33TKa3EMqyHZeCcNurP+r6
SLNLIi1U6d8gMIDWqkEoMUkxggGXMIIBkwIBATA9MC8xLTArBgNVBAMTJEZ1aml0c3UgVGVj
aG5vbG9neSBTb2x1dGlvbnMgVXNlciBDQQIKNgudswAAAAJUwzAJBgUrDgMCGgUAoIGxMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDIxNTExMDAxNlow
IwYJKoZIhvcNAQkEMRYEFM7zBao7OiR4hf9w1inrXORYQvm4MFIGCSqGSIb3DQEJDzFFMEMw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIGAduGTzZpsSDFb33+/cgv63J0MXndK/5hm
O04HYZeIRJJleiR9iqFRzovxiRkv5DfRJv1Mar7SP20GBMoLZycVh4whYYtwDtHPap4ttz/J
1dh+44sepCGWqzYEk/dbIqQOvEanQM+xcJ/HcINgzx1XU+WEBME57LN7w8pjnO0dgaM=

--cmJC7u66zC7hs+87--
