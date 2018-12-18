Received: from eggs.gnu.org ([2001:4830:134:3::10]:56039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZGsa-0004L4-Ho
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZGsU-0006Nf-TN
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:01:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZGsU-0006NJ-Ma
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:01:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81B2D4025F
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 12:35:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181216140902.23986-1-marcandre.lureau@redhat.com>
	<20181216140902.23986-11-marcandre.lureau@redhat.com>
Date: Tue, 18 Dec 2018 13:35:16 +0100
In-Reply-To: <20181216140902.23986-11-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Sun, 16 Dec 2018
	18:08:59 +0400")
Message-ID: <8736qvhv23.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/13] qapi: make query-cpu-model-expansion
 depend on s390 or x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Doesn't build linux-user:

    target/i386/cpu.o: In function `qmp_query_cpu_model_expansion':
    /work/armbru/qemu/target/i386/cpu.c:4082: undefined reference to `qapi_=
free_CpuModelExpansionInfo'
    collect2: error: ld returned 1 exit status
    make[1]: *** [Makefile:200: qemu-i386] Error 1

    target/i386/cpu.o: In function `qmp_query_cpu_model_expansion':
    /work/armbru/qemu/target/i386/cpu.c:4082: undefined reference to `qapi_=
free_CpuModelExpansionInfo'
    collect2: error: ld returned 1 exit status
    make[1]: *** [Makefile:200: qemu-x86_64] Error 1

Fixup:

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index dc0a7413a4..1554c0bd71 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3882,6 +3882,7 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefin=
ition *def, Error **errp)
=20
 }
=20
+#ifndef CONFIG_USER_ONLY
 /* Return a QDict containing keys for all properties that can be included
  * in static expansion of CPU models. All properties set by x86_cpu_load_d=
ef()
  * must be included in the dictionary.
@@ -4084,6 +4085,7 @@ out:
     }
     return ret;
 }
+#endif  /* !CONFIG_USER_ONLY */
=20
 static gchar *x86_gdb_arch_name(CPUState *cs)
 {
