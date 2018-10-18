Received: from eggs.gnu.org ([2001:4830:134:3::10]:43061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gD9er-0006O2-Fq
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gD9em-0000K9-QK
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gD9em-0000JW-E4
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:12 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 18 Oct 2018 15:52:01 +0100
Message-Id: <20181018145203.11336-3-berrange@redhat.com>
In-Reply-To: <20181018145203.11336-1-berrange@redhat.com>
References: <20181018145203.11336-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [web PATCH 2/4] Introduce content and tools for
 managing security notices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 _config.yml                                  |   4 +
 _includes/nav.html                           |   3 +-
 _layouts/secnotice.html                      |  22 ++
 assets/css/style.css                         |  47 +++
 secnotice/Makefile                           |  40 +++
 secnotice/README-template.md                 |  78 +++++
 secnotice/README.md                          |  20 ++
 secnotice/_scripts/index-html.xsl            |  72 +++++
 secnotice/_scripts/index-xml                 |  28 ++
 secnotice/_scripts/notice-html.xsl           | 286 +++++++++++++++++++
 secnotice/_scripts/notice-txt.xsl            | 277 ++++++++++++++++++
 secnotice/_scripts/report-vulnerable-tags.pl | 135 +++++++++
 secnotice/template.xml                       |  50 ++++
 13 files changed, 1061 insertions(+), 1 deletion(-)
 create mode 100644 _layouts/secnotice.html
 create mode 100644 secnotice/Makefile
 create mode 100644 secnotice/README-template.md
 create mode 100644 secnotice/README.md
 create mode 100644 secnotice/_scripts/index-html.xsl
 create mode 100755 secnotice/_scripts/index-xml
 create mode 100644 secnotice/_scripts/notice-html.xsl
 create mode 100644 secnotice/_scripts/notice-txt.xsl
 create mode 100644 secnotice/_scripts/report-vulnerable-tags.pl
 create mode 100644 secnotice/template.xml

diff --git a/_config.yml b/_config.yml
index 0a0201c..6fddace 100644
--- a/_config.yml
+++ b/_config.yml
@@ -37,3 +37,7 @@ gems:
 exclude:
   - Gemfile
   - Gemfile.lock
+  - Makefile
+  - secalert/README.md
+  - secalert/README-template.md
+  - secalert/template.xml
diff --git a/_includes/nav.html b/_includes/nav.html
index 241d83e..350de6d 100644
--- a/_includes/nav.html
+++ b/_includes/nav.html
@@ -6,7 +6,8 @@
 			</li><li {% if current[1] =3D=3D 'download' %}class=3D'current'{% end=
if %}><a href=3D"/download">Download</a>
 			</li><li {% if current[1] =3D=3D 'contribute' %}class=3D'current'{% e=
ndif %}><a href=3D"/contribute">Contribute</a>
 			</li><li {% if current[1] =3D=3D 'documentation' %}class=3D'current'{=
% endif %}><a href=3D"/documentation">Documentation</a>
-			</li><li {% if current[1] =3D=3D 'blog' %}class=3D'current'{% endif %=
}><a href=3D"/blog">Blog</a></li>
+			</li><li {% if current[1] =3D=3D 'blog' %}class=3D'current'{% endif %=
}><a href=3D"/blog">Blog</a>
+			</li><li {% if current[1] =3D=3D 'secnotice' %}class=3D'current'{% en=
dif %}><a href=3D"/secnotice">Security Notices</a></li>
 		</ul>
 	</nav>
=20
diff --git a/_layouts/secnotice.html b/_layouts/secnotice.html
new file mode 100644
index 0000000..b30c036
--- /dev/null
+++ b/_layouts/secnotice.html
@@ -0,0 +1,22 @@
+<!DOCTYPE HTML>
+<!--
+Linear by TEMPLATED
+templated.co @templatedco
+Released for free under the Creative Commons Attribution 3.0 license (te=
mplated.co/license)
+-->
+<html>
+<head>
+	<title>{{ page.title }} - {{ site.title }}</title>
+	{% include assets.html %}
+</head>
+<body class=3D"secnotice">
+
+	{% include nav.html %}
+
+	{{ content }}
+
+	{% include footer.html %}
+	{% include copyright.html %}
+
+</body>
+</html>
diff --git a/assets/css/style.css b/assets/css/style.css
index b828887..dccffb0 100644
--- a/assets/css/style.css
+++ b/assets/css/style.css
@@ -590,3 +590,50 @@
 	{
 		margin-top: 1.5em;
 	}
+
+/***********************************************************************=
**********/
+/* Security notices                                                     =
         */
+/***********************************************************************=
**********/
+
+	body.secnotice #main
+	{
+		width: 50%;
+	}
+
+	body.secnotice #sidebar
+	{
+		margin-top: 10em;
+		width: 30%;
+	}
+
+	body.secnotice p.altformat
+	{
+		font-size: smaller;
+		color: inherit;
+		text-align: right;
+	}
+
+	body.secnotice table.repository {
+	    border-spacing: 0px;
+	}
+
+	body.secnotice table.repository tbody th {
+	    text-align: right;
+	}
+
+	body.secnotice table.repository tbody th,
+	body.secnotice table.repository tbody td {
+	    padding: 2px;
+	}=09
+
+	body.secnotice table.repository tbody td.fixedtag,
+	body.secnotice table.repository tbody td.mergedcommit {
+	    background: rgb(240,255,240);
+	}
+	body.secnotice table.repository tbody td.fixedcommit {
+	    background: rgb(240,240,255);
+	}
+
+	body.secnotice table.repository thead {
+	    background: rgb(240,240,240);
+	}
diff --git a/secnotice/Makefile b/secnotice/Makefile
new file mode 100644
index 0000000..fef2e8c
--- /dev/null
+++ b/secnotice/Makefile
@@ -0,0 +1,40 @@
+
+YEARS =3D $(wildcard 2???)
+
+INDEX_XML =3D index.xml $(YEARS:%=3D%/index.xml)
+INDEX_HTML =3D $(INDEX_XML:%.xml=3D%.html)
+
+NOTICE_XML =3D $(wildcard */???.xml)
+NOTICE_TXT =3D $(NOTICE_XML:%.xml=3D%.txt)
+NOTICE_HTML =3D $(NOTICE_XML:%.xml=3D%.html)
+
+all: $(INDEX_XML) $(INDEX_HTML) $(NOTICE_TXT) $(NOTICE_HTML)
+
+index.xml: $(NOTICE_XML) _scripts/index-xml Makefile
+	mkdir -p `dirname $@`
+	_scripts/index-xml $(sort $(NOTICE_XML)) > $@
+
+index.html: index.xml _scripts/index-html.xsl Makefile
+	xsltproc _scripts/index-html.xsl $< > $@
+
+%/index.xml: $(NOTICE_XML) _scripts/index-xml Makefile
+	mkdir -p `dirname $@`
+	DIR=3D`echo $@ | sed -e 's,/index.xml,,'`
+	rm -f $@
+	_scripts/index-xml $(sort $(wildcard $(@:%/index.xml=3D%/)???.xml)) > $=
@
+
+%/index.html: %/index.xml _scripts/index-html.xsl Makefile
+	xsltproc --stringparam permalink $(@:%/index.html=3D/secnotice/%/) _scr=
ipts/index-html.xsl $< > $@
+
+%.txt: %.xml _scripts/notice-txt.xsl Makefile
+	mkdir -p `dirname $@`
+	xsltproc _scripts/notice-txt.xsl $< > $@
+
+%.html: %.xml _scripts/notice-html.xsl Makefile
+	mkdir -p `dirname $@`
+	xsltproc _scripts/notice-html.xsl $< > $@
+
+clean:
+	rm -rf index.{xml,html}
+	rm -rf */index.{xml,html}
+	rm -rf */*.{txt,html}
diff --git a/secnotice/README-template.md b/secnotice/README-template.md
new file mode 100644
index 0000000..2b80dca
--- /dev/null
+++ b/secnotice/README-template.md
@@ -0,0 +1,78 @@
+QEMU Security Notice Schema
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+The top level element of a QEMU security notice has a name of
+``security-notice`` and is in an XML namespace of
+``http://qemu.org/xmlns/security-notice/1.0``
+
+Basic metadata
+--------------
+
+The ``id`` element content is a pair of 4 digit numbers uniquely identif=
ying
+the security issue. By convention the first 4 digit number is the year i=
n which
+it was reported and the second number is an integer value that is unique=
 within
+the year, monotonically incrementing from 1. eg the 137th issue reported=
 in
+2013 would have an id of ``2013-0137``
+
+The ``summary`` element is a short, single line description of the flaw,
+ideally 80 characters or less to make it suitable for use in email subje=
ct
+lines or git commit messages.
+
+The ``credits`` element provides information on persons involved with th=
e flaw.
+It permits the child elements ``reporter`` or ``patcher`` each of which =
can be
+repeated zero or more times. Both elements contain two further child ele=
ments
+``email`` and ``name`` with the former providing the email address and t=
he
+latter providing the full name. At least one of ``email`` and ``name`` m=
ust
+be provided.
+
+The ``lifecycle`` element provides date on key milestones in handling of=
 the
+issue. It contains between one and three child elements, ``reported``,
+``published`` and ``fixed``. The ``reported`` element says the date on w=
hich
+the QEMU security received notification of the issue. The ``published`` =
element
+says the date on which the issue was revealed to the public. The ``fixed=
``
+element says the date on which the issue was patched in the primary code=
 branch
+(typically GIT master).
+
+The ``reference`` element provides details of related resources. It will=
 have
+one or more child elements which can be either ``advisory`` or ``bug``. =
An
+``advisory`` element includes a ``type`` and ``id`` attribute where ``ty=
pe`` is
+currently allowed to be ``CVE`` and ``id`` is the identifier of the repo=
rt. A
+``bug`` element includes ``tracker`` and ``id`` attributes where ``track=
er`` is
+allowed to be ``redhat``, ``debian`` or a short name for another vendors=
' bug
+tracker.
+
+Descriptive data
+----------------
+
+There are three free form text elements providing descriptive data about=
 the
+issue. The data will usually be inside a CDATA block.
+
+The ``description`` element content is an expanded version of the ``summ=
ary``
+element content, describing what the flaw is.
+
+The ``impact`` element content describes the implications of the securit=
y
+issue. ie what can a malicious user do with the flaw.
+
+The ``workaround`` element content describes any steps that an administr=
ator
+can take to eliminate or at least mitigate the impact of the flaw.
+
+
+Product data
+------------
+
+The ``product`` element provides information about the codebase of the a=
ffected
+products. The ``name`` attribute is the name of a QEMU product, typicall=
y based
+on the tar.gz archive name with the suffix stripped. This contains a chi=
ld
+``repository`` element which is a URL to the master GIT repository. Ther=
e is
+then one or more ``branch`` elements which details the state of affected
+branches.
+
+The first child of the ``branch`` element is a ``name`` giving the branc=
h name,
+eg ``master``, ``v1.0.1-maint``, etc. There are then zero or more ``tag`=
` or
+``change`` child elements with a ``state`` attribute of ``vulnerable`` o=
r
+``fixed``. The ``tag`` element content details the name of the GIT tag(s=
) on
+that branch are vulnerable and which tags are fixed. The ``change`` elem=
ent
+content details the GIT hash of the change(s) which both introduce and f=
ix the
+flaw. The same vulnerable change hash may appear under multiple ``branch=
``
+elements since branches will share large portions of their history. The =
fix
+hash will however usually be different.
diff --git a/secnotice/README.md b/secnotice/README.md
new file mode 100644
index 0000000..643076d
--- /dev/null
+++ b/secnotice/README.md
@@ -0,0 +1,20 @@
+QEMU Security Notices
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This directory records all QEMU Security Notices that are issued.
+
+Notices must only added to this directory once any embargo is lifted, si=
nce the
+GIT repository is fully public.
+
+Notices are written in XML in a file ``$YEAR/$NUM.xml`` eg ``2014/0001.x=
ml``.
+Assign numbers incrementally as new issues are reported.  More details o=
n the
+XML format can be found in `README-schema.rst``.
+
+When a new notice is published for the first time, send the text renderi=
ng of
+the notice to the ``qemu-devel@nongnu.org``
+
+When backporting security fixes to ``stable-X.Y`` branches, update the n=
otice
+with details of the backported changeset hash.
+
+When doing a formal stable release, update the notices included with the=
 release
+tag name.
diff --git a/secnotice/_scripts/index-html.xsl b/secnotice/_scripts/index=
-html.xsl
new file mode 100644
index 0000000..71ae716
--- /dev/null
+++ b/secnotice/_scripts/index-html.xsl
@@ -0,0 +1,72 @@
+<!--
+  - This program is free software; you can redistribute it and/or modify
+  - it under the terms of the GNU General Public License as published by
+  - the Free Software Foundation; either version 2 of the License, or
+  - (at your option) any later version.
+  -
+  - This program is distributed in the hope that it will be useful,
+  - but WITHOUT ANY WARRANTY; without even the implied warranty of
+  - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  - GNU General Public License for more details.
+  -
+  - You should have received a copy of the GNU General Public License
+  - along with this program.  If not, see
+  - <http://www.gnu.org/licenses/>.
+  -->
+<xsl:stylesheet
+  xmlns=3D"http://www.w3.org/1999/xhtml"
+  xmlns:xsl=3D"http://www.w3.org/1999/XSL/Transform"
+  xmlns:qsn=3D"http://qemu.org/xmlns/security-notice/1.0"
+  xmlns:qsnl=3D"http://qemu.org/xmlns/security-notice-list/1.0"
+  exclude-result-prefixes=3D"xsl qsn qsnl"
+  version=3D"1.0">
+
+  <xsl:output omit-xml-declaration=3D"yes" method=3D"xml" indent=3D"yes"=
 />
+
+  <xsl:param name=3D"permalink" select=3D"'/secnotice/'"/>
+
+  <xsl:template match=3D"/qsnl:security-notice-list">---
+title: QEMU Security Notices
+permalink: <xsl:value-of select=3D"$permalink"/>
+---
+
+   <p>
+     If you believe you have identified a new security issue in QEMU, pl=
ease
+     follow the <a href=3D"https://wiki.qemu.org/SecurityProcess">securi=
ty process</a>
+     to report it in a non-public way. Do <strong>NOT</strong> use the b=
ug tracker,
+     mailing lists, or IRC to report non-public security issues.
+   </p>
+
+    <ul>
+      <xsl:apply-templates select=3D"qsnl:security-notice">
+	<xsl:sort select=3D"@name" order=3D"descending" />
+      </xsl:apply-templates>
+    </ul>
+
+    <p class=3D"alt">
+      Alternative formats: <a href=3D"index.xml">[xml]</a>
+    </p>
+  </xsl:template>
+
+  <xsl:template name=3D"qsnhref">
+    <xsl:param name=3D"id"/>
+
+    <xsl:variable name=3D"dir" select=3D"substring-before($id, '-')"/>
+    <xsl:variable name=3D"file" select=3D"substring-after($id, '-')"/>
+
+    <xsl:value-of select=3D"concat($dir, '/', $file)"/>
+  </xsl:template>
+
+  <xsl:template match=3D"qsnl:security-notice">
+    <xsl:variable name=3D"notice" select=3D"document(concat('../../', @n=
ame))"/>
+    <xsl:variable name=3D"id" select=3D"$notice/qsn:security-notice/qsn:=
id"/>
+    <xsl:variable name=3D"summary" select=3D"$notice/qsn:security-notice=
/qsn:summary"/>
+    <xsl:variable name=3D"href">
+      <xsl:call-template name=3D"qsnhref">
+	<xsl:with-param name=3D"id" select=3D"$id"/>
+      </xsl:call-template>
+    </xsl:variable>
+
+    <li><a href=3D"{$href}">QSN-<xsl:value-of select=3D"$id"/>: <xsl:val=
ue-of select=3D"$summary"/></a></li>
+  </xsl:template>
+</xsl:stylesheet>
diff --git a/secnotice/_scripts/index-xml b/secnotice/_scripts/index-xml
new file mode 100755
index 0000000..67de29f
--- /dev/null
+++ b/secnotice/_scripts/index-xml
@@ -0,0 +1,28 @@
+#!/bin/bash
+#
+# Copyright (C) 2013-2014 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see
+# <http://www.gnu.org/licenses/>.
+
+set -e
+
+DIR=3D"$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
+
+echo '<security-notice-list xmlns=3D"http://qemu.org/xmlns/security-noti=
ce-list/1.0">'
+for n in $@
+do
+  echo "  <security-notice name=3D'/secnotice/$n'/>"
+done
+echo '</security-notice-list>'
diff --git a/secnotice/_scripts/notice-html.xsl b/secnotice/_scripts/noti=
ce-html.xsl
new file mode 100644
index 0000000..50ba802
--- /dev/null
+++ b/secnotice/_scripts/notice-html.xsl
@@ -0,0 +1,286 @@
+<!--
+  - This program is free software; you can redistribute it and/or modify
+  - it under the terms of the GNU General Public License as published by
+  - the Free Software Foundation; either version 2 of the License, or
+  - (at your option) any later version.
+  -
+  - This program is distributed in the hope that it will be useful,
+  - but WITHOUT ANY WARRANTY; without even the implied warranty of
+  - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  - GNU General Public License for more details.
+  -
+  - You should have received a copy of the GNU General Public License
+  - along with this program.  If not, see
+  - <http://www.gnu.org/licenses/>.
+  -->
+<xsl:stylesheet
+  xmlns=3D"http://www.w3.org/1999/xhtml"
+  xmlns:xsl=3D"http://www.w3.org/1999/XSL/Transform"
+  xmlns:qsn=3D"http://qemu.org/xmlns/security-notice/1.0"
+  exclude-result-prefixes=3D"xsl qsn"
+  version=3D"1.0">
+
+  <xsl:output omit-xml-declaration=3D"yes" method=3D"xml" indent=3D"yes"=
 />
+
+  <xsl:template name=3D"selfhref">
+    <xsl:param name=3D"id"/>
+    <xsl:param name=3D"ext"/>
+
+    <xsl:variable name=3D"dir" select=3D"substring-before($id, '-')"/>
+    <xsl:variable name=3D"file" select=3D"substring-after($id, '-')"/>
+
+    <xsl:value-of select=3D"concat('/secnotice/', $dir, '/', $file, $ext=
)"/>
+  </xsl:template>
+
+  <xsl:template match=3D"/qsn:security-notice">---
+title: 'QSN-<xsl:value-of select=3D"qsn:id"/>: <xsl:value-of select=3D"q=
sn:summary"/>'
+layout: secnotice
+permalink: <xsl:call-template name=3D"selfhref">
+  <xsl:with-param name=3D"id" select=3D"qsn:id"/>
+</xsl:call-template>
+---
+
+    <div id=3D"main">
+      <div class=3D"container">
+
+	<h2>
+	  <xsl:value-of select=3D"qsn:summary"/>
+	</h2>
+
+	<xsl:apply-templates select=3D"qsn:lifecycle"/>
+	<xsl:apply-templates select=3D"qsn:credits"/>
+
+	<xsl:apply-templates select=3D"qsn:reference"/>
+	<xsl:apply-templates select=3D"qsn:description"/>
+	<xsl:apply-templates select=3D"qsn:impact"/>
+	<xsl:apply-templates select=3D"qsn:mitigation"/>
+
+	<xsl:call-template name=3D"selflink"/>
+      </div>
+    </div>
+
+    <div id=3D"sidebar">
+      <div class=3D"container">
+	<section>
+	  <header>
+	    <h2>Related commits</h2>
+	  </header>
+	  <xsl:apply-templates select=3D"qsn:repository"/>
+	</section>
+      </div>
+    </div>
+  </xsl:template>
+
+  <xsl:template name=3D"selflink">
+    <p class=3D"altformat">
+      Alternative formats:
+      <a>
+	<xsl:attribute name=3D"href">
+	  <xsl:call-template name=3D"selfhref">
+	    <xsl:with-param name=3D"id" select=3D"qsn:id"/>
+	    <xsl:with-param name=3D"ext" select=3D"'.xml'"/>
+	  </xsl:call-template>
+	</xsl:attribute>
+	<xsl:text>[xml]</xsl:text>
+      </a>
+      <xsl:text> </xsl:text>
+      <a>
+	<xsl:attribute name=3D"href">
+	  <xsl:call-template name=3D"selfhref">
+	    <xsl:with-param name=3D"id" select=3D"qsn:id"/>
+	    <xsl:with-param name=3D"ext" select=3D"'.txt'"/>
+	  </xsl:call-template>
+	</xsl:attribute>
+	<xsl:text>[text]</xsl:text>
+      </a>
+    </p>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:lifecycle">
+    <h3>Lifecycle</h3>
+    <table>
+      <tr>
+	<th>Reported on:</th>
+	<td><xsl:value-of select=3D"qsn:reported"/></td>
+      </tr>
+      <tr>
+	<th>Published on:</th>
+	<td><xsl:value-of select=3D"qsn:published"/></td>
+      </tr>
+      <tr>
+	<th>Fixed on:</th>
+	<td><xsl:value-of select=3D"qsn:fixed"/></td>
+      </tr>
+    </table>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:credits">
+    <h3>Credits</h3>
+    <table>
+      <xsl:for-each select=3D"qsn:reporter">
+	<tr>
+	  <xsl:if test=3D"position() =3D 1">
+	    <th>Reported by:</th>
+	  </xsl:if>
+	  <xsl:if test=3D"position() > 1">
+	    <th></th>
+	  </xsl:if>
+	  <td>
+	    <a href=3D"mailto:{qsn:email}"><xsl:value-of select=3D"qsn:name"/><=
/a>
+	  </td>
+	</tr>
+      </xsl:for-each>
+      <xsl:for-each select=3D"qsn:patcher">
+	<tr>
+	  <xsl:if test=3D"position() =3D 1">
+	    <th>Patched by:</th>
+	  </xsl:if>
+	  <xsl:if test=3D"position() > 1">
+	    <th></th>
+	  </xsl:if>
+	  <td>
+	    <a href=3D"mailto:{qsn:email}"><xsl:value-of select=3D"qsn:name"/><=
/a>
+	  </td>
+	</tr>
+      </xsl:for-each>
+    </table>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:advisory">
+    <xsl:choose>
+      <xsl:when test=3D"@type=3D'CVE'">
+	<a href=3D"https://nvd.nist.gov/vuln/detail/CVE-{@id}">
+	  <xsl:text>CVE-</xsl:text>
+	  <xsl:value-of select=3D"@id"/>
+	</a>
+      </xsl:when>
+      <xsl:otherwise>
+	<xsl:value-of select=3D"@type"/>
+	<xsl:text>-</xsl:text>
+	<xsl:value-of select=3D"@id"/>
+      </xsl:otherwise>
+    </xsl:choose>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:bug">
+    <xsl:value-of select=3D"@tracker"/>
+    <xsl:text> bug #</xsl:text>
+    <xsl:value-of select=3D"@id"/>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:reference">
+    <h3>See also</h3>
+    <ul>
+    <xsl:for-each select=3D"qsn:advisory|qsn:bug">
+      <li><xsl:apply-templates select=3D"."/></li>
+    </xsl:for-each>
+    </ul>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:description">
+    <h3>Description</h3>
+    <p>
+      <xsl:value-of select=3D"."/>
+    </p>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:impact">
+    <h3>Impact</h3>
+    <p>
+      <xsl:value-of select=3D"."/>
+    </p>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:mitigation">
+    <h3>Mitigation</h3>
+    <p>
+      <xsl:value-of select=3D"."/>
+    </p>
+  </xsl:template>
+
+  <xsl:template name=3D"gitbranch">
+    <xsl:param name=3D"branch"/>
+
+    <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/h=
eads/{$branch}"><xsl:value-of select=3D"$branch"/></a>
+  </xsl:template>
+
+  <xsl:template name=3D"gittag">
+    <xsl:param name=3D"tag"/>
+
+    <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3D{$tag}"><xs=
l:value-of select=3D"$tag"/></a>
+  </xsl:template>
+
+  <xsl:template name=3D"gitchange">
+    <xsl:param name=3D"change"/>
+
+    <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D{$change=
}"><xsl:value-of select=3D"$change"/></a>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:repository">
+    <xsl:for-each select=3D"qsn:branch">
+      <table class=3D"repository">
+	<thead>
+	  <tr>
+	    <th colspan=3D"2">Branch:
+	      <xsl:call-template name=3D"gitbranch">
+		<xsl:with-param name=3D"branch" select=3D"qsn:name"/>
+	      </xsl:call-template>
+	    </th>
+	  </tr>
+	</thead>
+	<tbody>
+	  <xsl:for-each select=3D"qsn:tag[@state=3D'fixed']">
+	    <tr>
+	      <th>Fixed in:</th>
+	      <td class=3D"fixedtag">
+		<xsl:call-template name=3D"gittag">
+		  <xsl:with-param name=3D"tag" select=3D"."/>
+		</xsl:call-template>
+	      </td>
+	    </tr>
+	  </xsl:for-each>
+	  <xsl:for-each select=3D"qsn:change[@state=3D'fixed']">
+	    <tr>
+	      <th>Fixed by:</th>
+	      <td class=3D"fixedcommit">
+		<xsl:call-template name=3D"gitchange">
+		  <xsl:with-param name=3D"change" select=3D"."/>
+		</xsl:call-template>
+	      </td>
+	    </tr>
+	  </xsl:for-each>
+	  <xsl:for-each select=3D"qsn:change[@state=3D'merged']">
+	    <tr>
+	      <th>Merged by:</th>
+	      <td class=3D"mergedcommit">
+		<xsl:call-template name=3D"gitchange">
+		  <xsl:with-param name=3D"change" select=3D"."/>
+		</xsl:call-template>
+	      </td>
+	    </tr>
+	  </xsl:for-each>
+	  <xsl:for-each select=3D"qsn:tag[@state=3D'vulnerable']">
+	    <tr>
+	      <th>Broken in:</th>
+	      <td class=3D"brokentag">
+		<xsl:call-template name=3D"gittag">
+		  <xsl:with-param name=3D"tag" select=3D"."/>
+		</xsl:call-template>
+	      </td>
+	  </tr>
+	  </xsl:for-each>
+	  <xsl:for-each select=3D"qsn:change[@state=3D'vulnerable']">
+	    <tr>
+	      <th>Broken by:</th>
+	      <td class=3D"brokencommit">
+		<xsl:call-template name=3D"gitchange">
+		  <xsl:with-param name=3D"change" select=3D"."/>
+		</xsl:call-template>
+	      </td>
+	    </tr>
+	  </xsl:for-each>
+	</tbody>
+      </table>
+    </xsl:for-each>
+  </xsl:template>
+</xsl:stylesheet>
diff --git a/secnotice/_scripts/notice-txt.xsl b/secnotice/_scripts/notic=
e-txt.xsl
new file mode 100644
index 0000000..dc4c125
--- /dev/null
+++ b/secnotice/_scripts/notice-txt.xsl
@@ -0,0 +1,277 @@
+<!--
+  - This program is free software; you can redistribute it and/or modify
+  - it under the terms of the GNU General Public License as published by
+  - the Free Software Foundation; either version 2 of the License, or
+  - (at your option) any later version.
+  -
+  - This program is distributed in the hope that it will be useful,
+  - but WITHOUT ANY WARRANTY; without even the implied warranty of
+  - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  - GNU General Public License for more details.
+  -
+  - You should have received a copy of the GNU General Public License
+  - along with this program.  If not, see
+  - <http://www.gnu.org/licenses/>.
+  -->
+<xsl:stylesheet
+  xmlns=3D"http://www.w3.org/1999/xhtml"
+  xmlns:xsl=3D"http://www.w3.org/1999/XSL/Transform"
+  xmlns:qsn=3D"http://qemu.org/xmlns/security-notice/1.0"
+  exclude-result-prefixes=3D"xsl qsn"
+  version=3D"1.0">
+
+  <xsl:output method=3D"text"/>
+
+  <xsl:variable name=3D"nl">
+    <xsl:text>
+</xsl:text>
+  </xsl:variable>
+
+  <!-- based on http://plasmasturm.org/log/xslwordwrap/ -->
+  <!-- Copyright 2010 Aristotle Pagaltzis; under the MIT licence -->
+  <!-- http://www.opensource.org/licenses/mit-license.php -->
+  <xsl:template name=3D"wrap-string">
+    <xsl:param name=3D"str" />
+    <xsl:param name=3D"wrap-col" />
+    <xsl:param name=3D"break-mark" />
+    <xsl:param name=3D"pos" select=3D"0" />
+    <xsl:choose>
+      <xsl:when test=3D"contains( $str, ' ' )">
+	<xsl:variable name=3D"first-word" select=3D"substring-before( $str, ' '=
 )" />
+	<xsl:variable name=3D"pos-now" select=3D"$pos + 1 + string-length( $fir=
st-word )" />
+	<xsl:choose>
+          <xsl:when test=3D"$pos > 0 and $pos-now >=3D $wrap-col">
+            <xsl:copy-of select=3D"$break-mark" />
+            <xsl:call-template name=3D"wrap-string">
+              <xsl:with-param name=3D"str" select=3D"$str" />
+              <xsl:with-param name=3D"wrap-col" select=3D"$wrap-col" />
+              <xsl:with-param name=3D"break-mark" select=3D"$break-mark"=
 />
+              <xsl:with-param name=3D"pos" select=3D"0" />
+            </xsl:call-template>
+          </xsl:when>
+          <xsl:otherwise>
+            <xsl:if test=3D"$pos > 0">
+              <xsl:text> </xsl:text>
+            </xsl:if>
+            <xsl:value-of select=3D"$first-word" />
+            <xsl:call-template name=3D"wrap-string">
+              <xsl:with-param name=3D"str" select=3D"substring-after( $s=
tr, ' ' )" />
+              <xsl:with-param name=3D"wrap-col" select=3D"$wrap-col" />
+              <xsl:with-param name=3D"break-mark" select=3D"$break-mark"=
 />
+              <xsl:with-param name=3D"pos" select=3D"$pos-now" />
+            </xsl:call-template>
+          </xsl:otherwise>
+	</xsl:choose>
+      </xsl:when>
+      <xsl:otherwise>
+	<xsl:choose>
+          <xsl:when test=3D"$pos + string-length( $str ) >=3D $wrap-col"=
>
+            <xsl:copy-of select=3D"$break-mark" />
+          </xsl:when>
+          <xsl:otherwise>
+            <xsl:if test=3D"$pos > 0">
+              <xsl:text> </xsl:text>
+            </xsl:if>
+          </xsl:otherwise>
+	</xsl:choose>
+	<xsl:value-of select=3D"$str" />
+      </xsl:otherwise>
+    </xsl:choose>
+  </xsl:template>
+
+  <xsl:template match=3D"/qsn:security-notice">
+    <xsl:text>        QEMU Security Notice: QSN-</xsl:text>
+    <xsl:value-of select=3D"qsn:id"/>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:text>        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</xsl:text>
+    <xsl:value-of select=3D"$nl"/>
+
+    <xsl:value-of select=3D"$nl"/>
+
+
+    <xsl:apply-templates select=3D"qsn:summary"/>
+    <xsl:apply-templates select=3D"qsn:lifecycle"/>
+    <xsl:apply-templates select=3D"qsn:credits"/>
+    <xsl:apply-templates select=3D"qsn:reference"/>
+    <xsl:apply-templates select=3D"qsn:description"/>
+    <xsl:apply-templates select=3D"qsn:impact"/>
+    <xsl:apply-templates select=3D"qsn:mitigation"/>
+    <xsl:apply-templates select=3D"qsn:repository"/>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:summary">
+    <xsl:text>       Summary: </xsl:text>
+    <xsl:call-template name=3D"wrap-string">
+      <xsl:with-param name=3D"str" select=3D"normalize-space(.)"/>
+      <xsl:with-param name=3D"wrap-col" select=3D"52"/>
+      <xsl:with-param name=3D"break-mark" select=3D"concat($nl, '       =
         ')"/>
+    </xsl:call-template>
+    <xsl:value-of select=3D"$nl"/>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:lifecycle">
+    <xsl:text>   Reported on: </xsl:text>
+    <xsl:value-of select=3D"qsn:reported"/>
+    <xsl:value-of select=3D"$nl"/>
+
+    <xsl:text>  Published on: </xsl:text>
+    <xsl:value-of select=3D"qsn:published"/>
+    <xsl:value-of select=3D"$nl"/>
+
+    <xsl:text>      Fixed on: </xsl:text>
+    <xsl:value-of select=3D"qsn:fixed"/>
+    <xsl:value-of select=3D"$nl"/>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:credits">
+    <xsl:text>   Reported by: </xsl:text>
+    <xsl:for-each select=3D"qsn:reporter">
+      <xsl:if test=3D"position() > 1">
+	<xsl:text>                </xsl:text>
+      </xsl:if>
+      <xsl:value-of select=3D"qsn:name"/>
+      <xsl:text> &lt;</xsl:text>
+      <xsl:value-of select=3D"qsn:email"/>
+      <xsl:text>&gt;</xsl:text>
+      <xsl:if test=3D"position() !=3D last()">
+	<xsl:value-of select=3D"$nl"/>
+      </xsl:if>
+    </xsl:for-each>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:text>    Patched by: </xsl:text>
+    <xsl:for-each select=3D"qsn:patcher">
+      <xsl:if test=3D"position() > 1">
+	<xsl:text>                </xsl:text>
+      </xsl:if>
+      <xsl:value-of select=3D"qsn:name"/>
+      <xsl:text> &lt;</xsl:text>
+      <xsl:value-of select=3D"qsn:email"/>
+      <xsl:text>&gt;</xsl:text>
+      <xsl:if test=3D"position() !=3D last()">
+	<xsl:value-of select=3D"concat(',',$nl)"/>
+      </xsl:if>
+    </xsl:for-each>
+    <xsl:value-of select=3D"$nl"/>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:advisory">
+    <xsl:value-of select=3D"@type"/>
+    <xsl:text>-</xsl:text>
+    <xsl:value-of select=3D"@id"/>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:bug">
+    <xsl:value-of select=3D"@tracker"/>
+    <xsl:text> bug #</xsl:text>
+    <xsl:value-of select=3D"@id"/>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:reference">
+    <xsl:text>      See also: </xsl:text>
+    <xsl:variable name=3D"refs">
+      <xsl:for-each select=3D"qsn:advisory|qsn:bug">
+	<xsl:apply-templates select=3D"."/>
+	<xsl:if test=3D"position() !=3D last()">
+	  <xsl:text>, </xsl:text>
+	</xsl:if>
+      </xsl:for-each>
+    </xsl:variable>
+    <xsl:call-template name=3D"wrap-string">
+      <xsl:with-param name=3D"str" select=3D"$refs"/>
+      <xsl:with-param name=3D"wrap-col" select=3D"52"/>
+      <xsl:with-param name=3D"break-mark" select=3D"concat($nl, '       =
         ')"/>
+    </xsl:call-template>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:value-of select=3D"$nl"/>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:description">
+    <xsl:text>Description</xsl:text>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:text>-----------</xsl:text>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:call-template name=3D"wrap-string">
+      <xsl:with-param name=3D"str" select=3D"normalize-space(.)"/>
+      <xsl:with-param name=3D"wrap-col" select=3D"70"/>
+      <xsl:with-param name=3D"break-mark" select=3D"$nl"/>
+    </xsl:call-template>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:value-of select=3D"$nl"/>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:impact">
+    <xsl:text>Impact</xsl:text>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:text>------</xsl:text>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:call-template name=3D"wrap-string">
+      <xsl:with-param name=3D"str" select=3D"normalize-space(.)"/>
+      <xsl:with-param name=3D"wrap-col" select=3D"70"/>
+      <xsl:with-param name=3D"break-mark" select=3D"$nl"/>
+    </xsl:call-template>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:value-of select=3D"$nl"/>
+  </xsl:template>
+
+  <xsl:template match=3D"qsn:mitigation">
+    <xsl:text>Mitigation</xsl:text>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:text>----------</xsl:text>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:call-template name=3D"wrap-string">
+      <xsl:with-param name=3D"str" select=3D"normalize-space(.)"/>
+      <xsl:with-param name=3D"wrap-col" select=3D"70"/>
+      <xsl:with-param name=3D"break-mark" select=3D"$nl"/>
+    </xsl:call-template>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:value-of select=3D"$nl"/>
+  </xsl:template>
+
+
+  <xsl:template match=3D"qsn:repository">
+    <xsl:text>Related commits</xsl:text>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:text>----------------</xsl:text>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:text>  git://git.qemu.org/qemu.git</xsl:text>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:text>  https://git.qemu.org/?p=3Dqemu.git</xsl:text>
+    <xsl:value-of select=3D"$nl"/>
+    <xsl:value-of select=3D"$nl"/>
+
+    <xsl:for-each    select=3D"qsn:branch">
+      <xsl:text>      Branch: </xsl:text>
+      <xsl:value-of select=3D"qsn:name"/>
+      <xsl:value-of select=3D"$nl"/>
+      <xsl:if test=3D"count(qsn:tag)">
+	<xsl:for-each select=3D"qsn:tag[@state=3D'vulnerable']">
+	  <xsl:text>   Broken in: </xsl:text>
+	  <xsl:value-of select=3D"."/>
+	  <xsl:value-of select=3D"$nl"/>
+	</xsl:for-each>
+	<xsl:for-each select=3D"qsn:tag[@state=3D'fixed']">
+	  <xsl:text>    Fixed in: </xsl:text>
+	  <xsl:value-of select=3D"."/>
+	  <xsl:value-of select=3D"$nl"/>
+	</xsl:for-each>
+      </xsl:if>
+      <xsl:if test=3D"count(qsn:change)">
+	<xsl:for-each select=3D"qsn:change[@state=3D'vulnerable']">
+	  <xsl:text>   Broken by: </xsl:text>
+	  <xsl:value-of select=3D"."/>
+	  <xsl:value-of select=3D"$nl"/>
+	</xsl:for-each>
+	<xsl:for-each select=3D"qsn:change[@state=3D'fixed']">
+	  <xsl:text>    Fixed by: </xsl:text>
+	  <xsl:value-of select=3D"."/>
+	  <xsl:value-of select=3D"$nl"/>
+	</xsl:for-each>
+      </xsl:if>
+      <xsl:value-of select=3D"$nl"/>
+    </xsl:for-each>
+  </xsl:template>
+</xsl:stylesheet>
diff --git a/secnotice/_scripts/report-vulnerable-tags.pl b/secnotice/_sc=
ripts/report-vulnerable-tags.pl
new file mode 100644
index 0000000..3b89efd
--- /dev/null
+++ b/secnotice/_scripts/report-vulnerable-tags.pl
@@ -0,0 +1,135 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+use Sort::Versions;
+
+if (int(@ARGV) !=3D 1 && int (@ARGV) !=3D 2) {
+    die "syntax: $0 BROKEN-COMMIT [MERGED-COMMIT]\n";
+}
+
+my $broken =3D shift @ARGV;
+my $merged =3D shift @ARGV;
+
+sub get_tags {
+    my @args =3D @_;
+
+    my @tags;
+    open GIT, "-|", "git", "tag", @args or
+    die "cannot query 'git tags @args': $!\n";
+
+    while (<GIT>) {
+        chomp;
+
+        # Drop anything except  vN.N.N style tags
+        # where 'N' is only digits.
+        if (/^v(\d+)(\.\d+)+$/) {
+            push @tags, $_;
+        }
+    }
+
+    close GIT;
+
+    return @tags;
+}
+
+sub get_branch {
+    my $tag =3D shift;
+
+    my @branches;
+    open GIT, "-|", "git", "branch", "--all", "--contains", $tag or
+    die "cannot query 'git branch --all --contains $tag': $!\n";
+
+    while (<GIT>) {
+        chomp;
+
+        if (m,^\s*remotes/origin/(stable-.*)$,) {
+            push @branches, $1;
+        }
+    }
+
+    close GIT;
+
+    return @branches;
+}
+
+my @branches;
+my %tags;
+my %branches;
+
+my %merged;
+my $mergedtag;
+
+if (defined $merged) {
+    for my $tag (get_tags("--contains", $merged)) {
+	$merged{$tag} =3D 1;
+	$mergedtag =3D $tag unless defined $mergedtag;
+    }
+}
+
+$branches{"master"} =3D [];
+# Most tags live on master so lets get them first
+for my $tag (get_tags("--contains", $broken, "--merged", "master")) {
+    next if exists $merged{$tag};
+    push @{$branches{"master"}}, $tag;
+    $tags{$tag} =3D 1;
+}
+push @branches, "master";
+
+# Now we need slower work to find branches for
+# few remaining tags
+for my $tag (get_tags("--contains", $broken)) {
+
+    next if exists $tags{$tag};
+    next if exists $merged{$tag};
+    next if $tag =3D~ /v\d+\.\d+\.9\d/;
+
+    my @tagbranches =3D get_branch($tag);
+    if (int(@tagbranches) =3D=3D 0) {
+	if ($tag =3D~ "^v0.10") {
+	    @tagbranches =3D ("stable-0.10")
+	} elsif ($tag =3D~ "^v0") {
+	    @tagbranches =3D ("master")
+	} else {
+	    print "Tag $tag doesn't appear in any branch\n";
+	    next;
+	}
+    }
+
+    if (int(@tagbranches) > 1) {
+        print "Tag $tag appears in multiple branches\n";
+    }
+
+    unless (exists($branches{$tagbranches[0]})) {
+        $branches{$tagbranches[0]} =3D [];
+        push @branches, $tagbranches[0];
+    }
+    push @{$branches{$tagbranches[0]}}, $tag;
+}
+
+
+foreach my $branch (sort versioncmp @branches) {
+    print "    <branch>\n";
+    print "      <name>$branch</name>\n";
+    if ($branch eq "master") {
+	print "      <change state=3D\"fixed\"></change>\n";
+	if (defined $merged) {
+	    print "      <change state=3D\"merged\">$merged</change>\n";
+	} else {
+	    print "      <change state=3D\"merged\"></change>\n";
+	}
+	if (defined $mergedtag) {
+	    print "      <tag state=3D\"fixed\">$mergedtag</tag>\n";
+	} else {
+	    print "      <tag state=3D\"fixed\"></tag>\n";
+	}
+    }
+
+    foreach my $tag (sort versioncmp @{$branches{$branch}}) {
+        print "      <tag state=3D\"vulnerable\">$tag</tag>\n";
+    }
+    print "      <change state=3D\"vulnerable\">$broken</change>\n";
+
+    print "    </branch>\n";
+}
diff --git a/secnotice/template.xml b/secnotice/template.xml
new file mode 100644
index 0000000..8f8a0d4
--- /dev/null
+++ b/secnotice/template.xml
@@ -0,0 +1,50 @@
+<security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
+  <id>XXXX-XXX</id>
+
+  <summary></summary>
+
+  <description>
+<![CDATA[]]>
+  </description>
+
+  <impact>
+<![CDATA[]]>
+  </impact>
+
+  <workaround>
+<![CDATA[]]>
+  </workaround>
+
+  <credits>
+    <reporter>
+      <name></name>
+      <email></email>
+    </reporter>
+    <patcher>
+      <name></name>
+      <email></email>
+    </patcher>
+  </credits>
+
+  <lifecycle>
+    <reported></reported>
+    <published></published>
+    <fixed></fixed>
+  </lifecycle>
+
+  <reference>
+    <advisory type=3D"CVE" id=3D"XXXX-XXXX"/>
+  </reference>
+
+  <repository>
+    <branch>
+      <name>master</name>
+      <tag state=3D"fixed"></tag>
+      <change state=3D"fixed"></change>
+      <change state=3D"merged"></change>
+      <change state=3D"vulnerable"></change>
+      <tag state=3D"vulnerable"></tag>
+    </branch>
+  </repository>
+
+</security-notice>
--=20
2.17.2
