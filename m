Received: from eggs.gnu.org ([209.51.188.92]:55013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1glaGD-00073g-G6
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1glaGB-0007XW-KK
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:09:09 -0500
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:39932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1glaGA-0007UA-To
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:09:07 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190111200943.GJ2738@work-vm>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
	<20190110201124.GJ2589@work-vm>
	<2578541547221793@myt5-68ad52a76c91.qloud-c.yandex.net>
	<20190111200943.GJ2738@work-vm>
MIME-Version: 1.0
Date: Mon, 21 Jan 2019 17:09:02 +0300
Message-Id: <3429361548079742@iva8-f16495710718.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/4] Add ignore-external migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>, Richard Henderson <rth@twiddle.net>, "clg@kaod.org" <clg@kaod.org>

Hi,

Just want to clarify your suggestions.

1) migrate=off/share=on

I'm not sure that adding new flag 'migrate=off' is a good idea. I think that
share=on as you suggested at first is enough.
* It's a new flag which has sense only with share=on
* It seems to that the meaning of this flag isn't clear. migrate=off isn't
  RAM_MIGRATABLE, it's rather RAM_IGNORABLE. I.e. it means that we don't migrate
  such block only if the capability is enabled.
If you don't mind, I'll prefer share=on and ignore-shared capability.

2) Keep RAM migration version

It's more complicated question. To validate GPAs for ignored blocks I have to
change the stream format. I can do this conditionally (if (cap_enabled) { ... })
but in this case, I want to make sure that the capability is enabled or disabled
on both source and target. Otherwise, there is an undefined behavior on the
target side (most likely some error during deserialization).
To fix that I can add a capability validation feature.

For example, add a new section to vmstate_configuration (not complete):
+static const VMStateDescription vmstate_capabilites = {
+    .name = "configuration/capabilities",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmstate_capabilites_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_V(caps_count, SaveState, 1),
+        VMSTATE_VARRAY_UINT32_ALLOC(capabilities, SaveState, caps_count, 1,
+                                    vmstate_info_bool, bool),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_configuration = {
     .name = "configuration",
     .version_id = 1,
@@ -404,6 +456,7 @@ static const VMStateDescription vmstate_configuration = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_target_page_bits,
+        &vmstate_capabilites,
         NULL
     }
 };

It seems too complicated. If I should change the migration stream anyway, maybe
it's better to increment the version?

What do you think?

Regards,
Yury
