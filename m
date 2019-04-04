Received: from eggs.gnu.org ([209.51.188.92]:38577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hByV1-00052t-9k
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hByV0-00046L-Dn
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:17:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56191)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hByV0-00044S-2J
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:17:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5AAC81227
	for <qemu-devel@nongnu.org>; Thu,  4 Apr 2019 09:17:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  4 Apr 2019 10:17:25 +0100
Message-Id: <20190404091725.20595-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] configure: fix pam test warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, berrange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The pam test generates a warning on Fedora 29 with -O3 compilation
because the headers declare that the pam_conversation pointer to
pam_start must be non-NULL.  Change it to use the same 0 initialised
structure as we actually use in qauthz.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 1c563a7027..73f7ad2be0 100755
--- a/configure
+++ b/configure
@@ -2946,9 +2946,9 @@ if test "$auth_pam" !=3D "no"; then
 int main(void) {
    const char *service_name =3D "qemu";
    const char *user =3D "frank";
-   const struct pam_conv *pam_conv =3D NULL;
+   const struct pam_conv pam_conv =3D { 0 };
    pam_handle_t *pamh =3D NULL;
-   pam_start(service_name, user, pam_conv, &pamh);
+   pam_start(service_name, user, &pam_conv, &pamh);
    return 0;
 }
 EOF
--=20
2.20.1
