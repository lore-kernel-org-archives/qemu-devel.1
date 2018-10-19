Received: from eggs.gnu.org ([2001:4830:134:3::10]:50290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDRyO-000546-LI
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDRyJ-0006SR-Ul
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDRyJ-0006Ko-9s
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:25:35 -0400
Date: Fri, 19 Oct 2018 11:25:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019102528.GG13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181018145203.11336-1-berrange@redhat.com>
	<c11576e1-9644-66e7-7dc6-b9d0ee4b537f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c11576e1-9644-66e7-7dc6-b9d0ee4b537f@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Thomas Huth <thuth@redhat.com>

On Thu, Oct 18, 2018 at 11:36:39PM +0200, Paolo Bonzini wrote:
> On 18/10/2018 16:51, Daniel P. Berrang=C3=A9 wrote:
> >=20
> > After adding the new $YEAR/$ID.xml file, 'make' will build the
> > corresponding indexes and HTML/TXT renderings. Ideally the machine wh=
ich
> > is hosting the QEMU website would run 'make' after pulling new
> > commits. In this series, however, I have just commited the rendered
> > content to git.
>=20
> "git push" is already running Jekyll, which has a templating mechanism
> similar to the one used for blog posts
> (https://jekyllrb.com/docs/collections/).  Basically one security notic=
e
> would be a file in a _secnotices directory, with the metadata in a YAML
> preamble like this:
>=20
> ---
> title: Speculative store bypass
> id: 2018-001
> date: 2018-05-21
> reported: 2018-03-12
> fixed: 2018-06-26
>=20
> credits:
>   - reporter:
>     - name: Ken Johnson (Microsoft Security Response Center)
>     - name: Jann Horn (Google Project Zero)
>   - patcher:
>     - name: Daniel P. Berrang=C3=A9
>       email: berrange@redhat.com
>     - name: Konrad Rzeszutek Wilk
>       email: konrad.wilk@oracle.com
>=20
> advisories:
>   - type: CVE
>     id: 2018-3639
>=20
> branches:
>   - master:
>       state: fixed
>       change:
>       - d19d1f965904a533998739698020ff4ee8a103da: fixed
>       - 403503b162ffc33fb64cfefdf7b880acf41772cd: fixed
>       - 4f50c1673a89b07f376ce5c42d22d79a79cd466d: merged
>       - a764f3f7197f4d7ad8fe8424269933de912224cb: fixed
>       - e409d9a158c77c650651e8118f6c86c8dc76eba6: merged
>       - 7ba1e61953f4592606e60b2e7507ff6a6faf861a: vulnerable
>       tag:
>       - v0.10.1: vulnerable
>     ...
> +---
>=20
> {% contentfor description %}
> An industry-wide issue was found in the way many modern microprocessor
> designs have implemented speculative execution of Load & Store
> instructions (a commonly used performance optimization).
> +
> +It relies on the presence of a precisely-defined instruction sequence
> in the privileged code as well as the fact that memory read from addres=
s
> to which a recent memory write has occurred may see an older value and
> subsequently cause an update into the microprocessor's data cache even
> for speculatively executed instructions that never actually commit (ret=
ire).
> {% endcontentfor %}
>=20
> {% contentfor impact %}
> As a result, an unprivileged attacker could use this flaw to read
> privileged memory by conducting targeted cache side-channel attacks.
> {% endcontentfor %}
>=20
> {% contentfor mitigation %}
> None
> {% endcontentfor %}
>=20
>=20
> (Requires the jekyll-contentblocks plugin).

I really don't want to use an application specific templating system.
While we're using Jekyll for the website today, I don't think it is
a good idea to assume that for the longer term.

Even today I can't actually run the jekyll website on my laptop because
the qemu-web content uses templating syntax from an older version of
Jekyll that has been deleted in the current Jekyll versions. So I have
to hack the code to remove pieces, in order to do testing.

> I am not a YAML fan, but I still would probably have to hide if I
> suggested using XSLT to convert the XML files to YAML. :)  Still, one
> question is obvious: is the XML an industry standard?  That would make
> it more palatable...

XML itself is an industry standard, so every OS has tools for querying
and transforming the documents in standard manner, which is the key thing
which is appealing to me.

Even though JSON itself is a standard, there's no standard equvalent to
XSLT or XPath for querying and transforming JSON. You end up having to
write programs to parse, and then reformat the data in alternative format=
s,
and the program itself has to be written portably. Document format
transformation is what XSLT excells at, IMHO.

This particular XML format isn't an industry standard.  NIST has an XML
schema for reporting CVEs, but it only partially overlaps with the bits
of data I record here.  So we would have to use XML namespaces to add
fields for the extra pieces we want - the GIT data is the biggest
pieces.

As with many standards though, NIST schema goes for extreme generality
at the cost of making it a very unfriendly document format for humans
to read. So don't think I could recommend using the NIST schema as a
master format - even I would hate using it. It is the kind of thing
you would want to generate from our more friendly format instead.

eg compare this NIST data for a recent QEMU flaw:

  <entry id=3D"CVE-2018-5683">
    <vuln:vulnerable-configuration id=3D"http://nvd.nist.gov/">
      <cpe-lang:logical-test operator=3D"OR" negate=3D"false">
        <cpe-lang:fact-ref name=3D"cpe:/a:qemu:qemu"/>
      </cpe-lang:logical-test>
    </vuln:vulnerable-configuration>
    <vuln:vulnerable-software-list>
      <vuln:product>cpe:/a:qemu:qemu</vuln:product>
    </vuln:vulnerable-software-list>
    <vuln:cve-id>CVE-2018-5683</vuln:cve-id>
    <vuln:published-datetime>2018-01-23T13:29:00.580-05:00</vuln:publishe=
d-datetime>
    <vuln:last-modified-datetime>2018-09-07T06:29:06.303-04:00</vuln:last=
-modified-datetime>
    <vuln:cvss>
      <cvss:base_metrics>
        <cvss:score>2.1</cvss:score>
        <cvss:access-vector>LOCAL</cvss:access-vector>
        <cvss:access-complexity>LOW</cvss:access-complexity>
        <cvss:authentication>NONE</cvss:authentication>
        <cvss:confidentiality-impact>NONE</cvss:confidentiality-impact>
        <cvss:integrity-impact>NONE</cvss:integrity-impact>
        <cvss:availability-impact>PARTIAL</cvss:availability-impact>
        <cvss:source>http://nvd.nist.gov</cvss:source>
        <cvss:generated-on-datetime>2018-02-12T11:20:01.123-05:00</cvss:g=
enerated-on-datetime>
      </cvss:base_metrics>
    </vuln:cvss>
    <vuln:cwe id=3D"CWE-125"/>
    <vuln:references xml:lang=3D"en" reference_type=3D"VENDOR_ADVISORY">
      <vuln:source>MLIST</vuln:source>
      <vuln:reference href=3D"http://www.openwall.com/lists/oss-security/=
2018/01/15/2" xml:lang=3D"en">[oss-security] 20180115 CVE-2018-5683 Qemu:=
 Out-of-bounds read in vga_draw_text routine</vuln:reference>
    </vuln:references>
    <vuln:references xml:lang=3D"en" reference_type=3D"VENDOR_ADVISORY">
      <vuln:source>BID</vuln:source>
      <vuln:reference href=3D"http://www.securityfocus.com/bid/102518" xm=
l:lang=3D"en">102518</vuln:reference>
    </vuln:references>
    <vuln:references xml:lang=3D"en" reference_type=3D"UNKNOWN">
      <vuln:source>REDHAT</vuln:source>
      <vuln:reference href=3D"https://access.redhat.com/errata/RHSA-2018:=
0816" xml:lang=3D"en">RHSA-2018:0816</vuln:reference>
    </vuln:references>
    <vuln:references xml:lang=3D"en" reference_type=3D"UNKNOWN">
      <vuln:source>REDHAT</vuln:source>
      <vuln:reference href=3D"https://access.redhat.com/errata/RHSA-2018:=
1104" xml:lang=3D"en">RHSA-2018:1104</vuln:reference>
    </vuln:references>
    <vuln:references xml:lang=3D"en" reference_type=3D"UNKNOWN">
      <vuln:source>REDHAT</vuln:source>
      <vuln:reference href=3D"https://access.redhat.com/errata/RHSA-2018:=
2162" xml:lang=3D"en">RHSA-2018:2162</vuln:reference>
    </vuln:references>
    <vuln:references xml:lang=3D"en" reference_type=3D"UNKNOWN">
      <vuln:source>MLIST</vuln:source>
      <vuln:reference href=3D"https://lists.debian.org/debian-lts-announc=
e/2018/09/msg00007.html" xml:lang=3D"en">[debian-lts-announce] 20180906 [=
SECURITY] [DLA 1497-1] qemu security update</vuln:reference>
    </vuln:references>
    <vuln:references xml:lang=3D"en" reference_type=3D"VENDOR_ADVISORY">
      <vuln:source>MLIST</vuln:source>
      <vuln:reference href=3D"https://lists.gnu.org/archive/html/qemu-dev=
el/2018-01/msg02597.html" xml:lang=3D"en">[Qemu-devel] 20180112 Re: [Qemu=
-devel] [PATCH v3] vga: check the validation of memory addr when draw tex=
t</vuln:reference>
    </vuln:references>
    <vuln:references xml:lang=3D"en" reference_type=3D"UNKNOWN">
      <vuln:source>UBUNTU</vuln:source>
      <vuln:reference href=3D"https://usn.ubuntu.com/3575-1/" xml:lang=3D=
"en">USN-3575-1</vuln:reference>
    </vuln:references>
    <vuln:references xml:lang=3D"en" reference_type=3D"UNKNOWN">
      <vuln:source>DEBIAN</vuln:source>
      <vuln:reference href=3D"https://www.debian.org/security/2018/dsa-42=
13" xml:lang=3D"en">DSA-4213</vuln:reference>
    </vuln:references>
    <vuln:summary>The vga_draw_text function in Qemu allows local OS gues=
t privileged users to cause a denial of service (out-of-bounds read and Q=
EMU process crash) by leveraging improper memory address validation.</vul=
n:summary>
  </entry>

With what I have proposed here:

    <security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
      <id>2018-002</id>
   =20
      <summary>VGA out of bounds in vga_draw_text</summary>
   =20
      <description>
    <![CDATA[Quick Emulator(QEMU) built with the VGA emulator support is
    vulnerable to an out-of-bounds access issue in vga_draw_text. It
    could occur while updating vga display area.]]>
      </description>
   =20
      <impact>
    <![CDATA[A privileged user inside guest could use this flaw to crash
    the Qemu process resulting in DoS.]]>
      </impact>
   =20
      <mitigation>
    <![CDATA[Disable graphics adapters if the virtual machines can be
    operated via the serial console]]>
      </mitigation>
   =20
      <credits>
        <reporter>
          <name>Jiang Xin</name>
          <email>jiangxin1@huawei.com</email>
        </reporter>
        <patcher>
          <name>Lin ZheCheng</name>
          <email>linzhecheng@huawei.com</email>
        </patcher>
      </credits>
   =20
      <lifecycle>
        <reported>20171228</reported>
        <published>20171225</published>
        <fixed>20180125</fixed>
      </lifecycle>
   =20
   =20
      <reference>
        <advisory type=3D"CVE" id=3D"2018-5683"/>
      </reference>
   =20
      <repository>
        <branch>
          <name>master</name>
          <tag state=3D"fixed">v2.12.0</tag>
          <change state=3D"fixed">191f59dc17396bb5a8da50f8c59b6e0a430711a=
4</change>
          <change state=3D"merged">b3bbe959b5dc3bf07041946455cc8e8d562bfd=
1f</change>
          <tag state=3D"vulnerable">v0.4.4</tag>
          <tag state=3D"vulnerable">v0.5.0</tag>
          ...snip...
        </branch>
        <branch>
          <name>stable-2.11</name>
          <tag state=3D"vulnerable">v2.11.1</tag>
          <tag state=3D"vulnerable">v2.11.2</tag>
          <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefd=
ab2105</change>
        </branch>
      </repository>
   =20
    </security-notice>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
