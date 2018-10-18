Received: from eggs.gnu.org ([2001:4830:134:3::10]:41391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDFyN-0003wx-C0
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDFyJ-0007JS-5g
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:36:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gDFyI-0007Bm-NI
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:36:46 -0400
References: <20181018145203.11336-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c11576e1-9644-66e7-7dc6-b9d0ee4b537f@redhat.com>
Date: Thu, 18 Oct 2018 23:36:39 +0200
MIME-Version: 1.0
In-Reply-To: <20181018145203.11336-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [web PATCH 0/4] Add web section reporting
 information about CVEs in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Thomas Huth <thuth@redhat.com>

On 18/10/2018 16:51, Daniel P. Berrang=C3=A9 wrote:
>=20
> After adding the new $YEAR/$ID.xml file, 'make' will build the
> corresponding indexes and HTML/TXT renderings. Ideally the machine whic=
h
> is hosting the QEMU website would run 'make' after pulling new
> commits. In this series, however, I have just commited the rendered
> content to git.

"git push" is already running Jekyll, which has a templating mechanism
similar to the one used for blog posts
(https://jekyllrb.com/docs/collections/).  Basically one security notice
would be a file in a _secnotices directory, with the metadata in a YAML
preamble like this:

---
title: Speculative store bypass
id: 2018-001
date: 2018-05-21
reported: 2018-03-12
fixed: 2018-06-26

credits:
  - reporter:
    - name: Ken Johnson (Microsoft Security Response Center)
    - name: Jann Horn (Google Project Zero)
  - patcher:
    - name: Daniel P. Berrang=C3=A9
      email: berrange@redhat.com
    - name: Konrad Rzeszutek Wilk
      email: konrad.wilk@oracle.com

advisories:
  - type: CVE
    id: 2018-3639

branches:
  - master:
      state: fixed
      change:
      - d19d1f965904a533998739698020ff4ee8a103da: fixed
      - 403503b162ffc33fb64cfefdf7b880acf41772cd: fixed
      - 4f50c1673a89b07f376ce5c42d22d79a79cd466d: merged
      - a764f3f7197f4d7ad8fe8424269933de912224cb: fixed
      - e409d9a158c77c650651e8118f6c86c8dc76eba6: merged
      - 7ba1e61953f4592606e60b2e7507ff6a6faf861a: vulnerable
      tag:
      - v0.10.1: vulnerable
    ...
+---

{% contentfor description %}
An industry-wide issue was found in the way many modern microprocessor
designs have implemented speculative execution of Load & Store
instructions (a commonly used performance optimization).
+
+It relies on the presence of a precisely-defined instruction sequence
in the privileged code as well as the fact that memory read from address
to which a recent memory write has occurred may see an older value and
subsequently cause an update into the microprocessor's data cache even
for speculatively executed instructions that never actually commit (retir=
e).
{% endcontentfor %}

{% contentfor impact %}
As a result, an unprivileged attacker could use this flaw to read
privileged memory by conducting targeted cache side-channel attacks.
{% endcontentfor %}

{% contentfor mitigation %}
None
{% endcontentfor %}


(Requires the jekyll-contentblocks plugin).

I am not a YAML fan, but I still would probably have to hide if I
suggested using XSLT to convert the XML files to YAML. :)  Still, one
question is obvious: is the XML an industry standard?  That would make
it more palatable...
