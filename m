Received: from eggs.gnu.org ([2001:4830:134:3::10]:34999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ef56p-0003rs-Kz
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ef56m-0005BK-EE
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:36:03 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:42404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ef56m-0005B7-B0
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:36:00 -0500
Received: by mail-qt0-f175.google.com with SMTP id c2so1695561qtn.9
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 06:36:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180126120306.19225-1-marcandre.lureau@redhat.com>
References: <20180126120306.19225-1-marcandre.lureau@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Fri, 26 Jan 2018 13:09:24 +0100
Message-ID: <CAMxuvazdE3VnxWaF0Z-T5BxExnC4uOnqwU9LiYvMsBSi6Tn85g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Hi,

Stash this to fix test leaks:

diff --git a/tests/tpm-crb-test.c b/tests/tpm-crb-test.c
index de78a28844..8bf1507e00 100644
--- a/tests/tpm-crb-test.c
+++ b/tests/tpm-crb-test.c
@@ -81,6 +81,7 @@ static void *emu_tpm_thread(void *data)

     g_free(s->tpm_msg);
     s->tpm_msg = NULL;
+    object_unref(OBJECT(s->tpm_ioc));
     return NULL;
 }

@@ -180,6 +181,8 @@ static void *emu_ctrl_thread(void *data)
         }
     }

+    object_unref(OBJECT(ioc));
+    object_unref(OBJECT(lioc));
     return NULL;
 }
