Received: from eggs.gnu.org ([2001:4830:134:3::10]:52524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1eXAAF-00061T-5d
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1eXAAC-0007yA-0E
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:22:51 -0500
Received: from mailpro.odiso.net ([89.248.211.110]:32784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1eXAAB-0007xK-Mg
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:22:47 -0500
Date: Thu, 4 Jan 2018 19:13:43 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <87448218.845975.1515089623014.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <20180104175609.9085-1-pbonzini@redhat.com>
References: <20180104175609.9085-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] add a blog post about "Spectre"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, ehabkost <ehabkost@redhat.com>

Thanks Paolo !

Do we need to update guest kernel too, if qemu use cpumodel=3Dqemu64 ?

(For example,  I have some very old guests where kernel update is not possi=
ble)

Regards,

Alexandre

----- Mail original -----
De: "pbonzini" <pbonzini@redhat.com>
=C3=80: "qemu-devel" <qemu-devel@nongnu.org>
Cc: "ehabkost" <ehabkost@redhat.com>
Envoy=C3=A9: Jeudi 4 Janvier 2018 18:56:09
Objet: [Qemu-devel] [qemu-web PATCH] add a blog post about "Spectre"

---=20
_posts/2018-01-04-spectre.md | 60 +++++++++++++++++++++++++++++++++++++++++=
+++=20
1 file changed, 60 insertions(+)=20
create mode 100644 _posts/2018-01-04-spectre.md=20

diff --git a/_posts/2018-01-04-spectre.md b/_posts/2018-01-04-spectre.md=20
new file mode 100644=20
index 0000000..1be86d0=20
--- /dev/null=20
+++ b/_posts/2018-01-04-spectre.md=20
@@ -0,0 +1,60 @@=20
+---=20
+layout: post=20
+title: "QEMU and the Spectre and Meltdown attacks"=20
+date: 2018-01-04 18:00:00 +0000=20
+author: Paolo Bonzini and Eduardo Habkost=20
+categories: [meltdown, spectre, security, x86]=20
+---=20
+As you probably know by now, three critical architectural flaws in CPUs ha=
ve=20
+been recently disclosed that allow user processes to read kernel or hyperv=
isor=20
+memory through cache side-channel attacks. These flaws, collectively=20
+named _Meltdown_ and _Spectre_, affect in one way or another almost=20
+all processors that perform out-of-order execution, including x86 (from=20
+Intel and AMD), POWER, s390 and ARM processors.=20
+=20
+No microcode updates are required to block the _Meltdown_ attack; it is=20
+enough to update the guest operating system to a version that separates=20
+the user and kernel address spaces (known as _page table isolation_ for=20
+the Linux kernel). Therefore, this post will focus on _Spectre_, and=20
+especially on [CVE-2017-5715](https://cve.mitre.org/cgi-bin/cvename.cgi?na=
me=3DCVE-2017-5715).=20
+=20
+Fixing or mitigating _Spectre_ in general, and CVE-2017-5715 in particular=
,=20
+requires cooperation between the processor and the operating system kernel=
 or=20
+hypervisor; the processor can be updated through microcode or millicode=20
+patches to provide the required functionality. CVE-2017-5715 allows guests=
=20
+to read potentially sensitive data from hypervisor memory; however, __patc=
hing=20
+the host kernel is sufficient to block this attack__.=20
+=20
+On the other hand, in order to protect the guest kernel from a malicious=
=20
+userspace, updates are also needed to the guest kernel and, depending on=
=20
+the processor architecture, to QEMU. Just like on bare-metal, the guest=20
+kernel will use the new functionality provided by the microcode or millico=
de=20
+updates. When running under a hypervisor, processor emulation is mostly ou=
t of=20
+QEMU's scope, so QEMU's role in the fix is small, but nevertheless importa=
nt.=20
+In the case of KVM:=20
+=20
+* QEMU configures the hypervisor to emulate a specific processor model.=20
+For x86, QEMU has to be aware of new CPUID bits introduced by the microcod=
e=20
+update, and it must provide them to guests depending on how the guest is=
=20
+configured.=20
+=20
+* upon virtual machine migration, QEMU reads the CPU state on the source=
=20
+and transmits it to the destination. For x86, QEMU has to be aware of new=
=20
+model specific registers (MSRs).=20
+=20
+Right now, there are no public patches to KVM that expose the new CPUID bi=
ts=20
+and MSRs to the virtual machines, therefore there is no urgent need to upd=
ate=20
+QEMU; remember that __updating the host kernel is enough to protect the=20
+host from malicious guests__. Nevertheless, updates will be posted to the=
=20
+qemu-devel mailing list in the next few days, and a 2.11.1 patch release=
=20
+will be released with the fix.=20
+=20
+As of today, the QEMU project is not aware of whether similar changes will=
=20
+be required for non-x86 processors. If so, they will also posted to the=20
+mailing list and backported to recent stable releases.=20
+=20
+For more information on the vulnerabilities, please refer to the [Google S=
ecurity=20
+Blog](https://security.googleblog.com/2018/01/todays-cpu-vulnerability-wha=
t-you-need.html)=20
+and [Google Project=20
+Zero](https://googleprojectzero.blogspot.it/2018/01/reading-privileged-mem=
ory-with-side.html)=20
+posts on the topic, as well as the [Spectre and Meltdown FAQ](https://melt=
downattack.com/#faq).=20
--=20
2.14.3=20
