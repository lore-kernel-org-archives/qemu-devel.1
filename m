Received: from eggs.gnu.org ([2001:4830:134:3::10]:42980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gD9ek-0006HS-HH
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gD9ei-0000GI-6o
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gD9eh-0000F7-RT
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:08 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 18 Oct 2018 15:51:59 +0100
Message-Id: <20181018145203.11336-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [web PATCH 0/4] Add web section reporting information
 about CVEs in QEMU
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

At the QEMU maintainer's summit in Prague we discussed QEMU's woeful
reporting and recording of security flaws

 - No CVE information is published unless it happened to be mentioned in
   the commit message
 - No analysis or information on when the flaw was first introduced in
   the code, and thus which versions are impacted
 - There is no collated list of vulnerabilities
 - Users / downstreams are not alerted when CVEs are fixed
 - There is no description of the impact of the bug or possible
   workarounds that can be used

Various 3rd parties do have some of this information. For example there
are various sites which collate lists of CVEs affecting projects, but
the information is quite minimal usually lacking details on the impact,
or possible workarounds.

Distro vendors typically look at when a flaw was introduced to determine
affected versions, but this information is not recorded anywhere.

What information is found is usually free form text making it difficult
to reliably process the data for analysis or reporting needs.

At the maintainer summit I volunteered address the problem of security
flaw reporting for QEMU. It took a bit longer than I expected to get
around it it, but I just got it working before this year's maintainer
summit :-)

This series addresses the problems by adding a new section to the QEMU
website with the following content:

 - "Security notices" heading is added to the navigation bar

 - At /secnotice/index.xml is a list of all known security flaws in a
   machine readable format

 - At /secnotice/ is the same information in human readable HTML format,
   auto-generated from the XML.

 - At /secnotice/$YEAR/$NUM.xml is detailed information in machine
   readable format for a single discovered flaw.

 - At /secnotice/$YEAR/$NUM is the same information in human readable
   HTML format, auto-generated from the XML

 - At /secnotice/$YEAR/$NUM.txt is the same information in human
   readable plain text format, auto-generated from the XML. This is
   suited for sending as email to the mailing list as an announcement.

At this point it is best to actually look at it running on a real site,
so I put up a static build of the qemu-web.git content for this series

  https://berrange.fedorapeople.org/qemu-sec/secnotice/

Taking one issue with multiboot from earlier this year:

  https://berrange.fedorapeople.org/qemu-sec/secnotice/2018/003
  https://berrange.fedorapeople.org/qemu-sec/secnotice/2018/003.txt
  https://berrange.fedorapeople.org/qemu-sec/secnotice/2018/003.xml

You can see there are a few distinct pieces of content about each issue

 - Lifecycle dates for

       * when it was reported
       * when it went public. Usually date when patch was posted for
         review or when it was publically mention in BZ or mailing
         list. Might differ from reported date if the initial reporting
         had an embargo.
       * when the fix merged to GIT master (ie Peter applied a PULL
         request)

 - Credits. Names / email of the people who discovered and reported the
   flaws, and people involved in writing patches to fix it. The latter
   is usually the git author.

 - External references. Typically the CVE ID number, but could also be a
   bug tracker name + number

 - Several free text blocks

      * description of what the flaw is
      * impact on the system when triggered/exploited
      * any ways to mitigate / workaround the impact

 - Git repository info

     * Commit hash where the flaw was introduced
     * Commit hash(s) where the flaw was fixed
     * Commit hash(s) where the flaw was merged
     * Tags containing the flaw on all branches
     * Tags containing the fix on git master and optionally stable
       branches

Reporting on a new issue is fairly straightforward. The
secnotice/template.xml file is cloned to the next available security
notice number for the current year eg  secnotice/2018/012.xml

Then it is simply a case of filling in the blanks in the template with
as little or much information as is available - all the fields are
optional, so can be left out if the info is not yet available.

Many key pieces of info will be available from the downstream distro
vendor who coordinates with upstream. For example the Red Hat CVE
links https://bugzilla.redhat.com/CVE-XXX-XXX usually contain the basic
description and impact, along with dates and credit for who reported it.

The hardest part is examining the GIT history to determine when the fix
was first introduced into the code. This is a case of using "git blame"
to trace back where the lines of troublesome code came from - often back
to the very first point the file was commited to QEMU.

Once the original commit hash is found, then there is a tool
secnotice/_scripts/report-vulnerable-tags.pl which will examine git tags
to determine which tags and branches contain the flaw. It will print the
snippet of XML suitable for copying into the template. It can optionally
accept the hash of the merge commit fixing the problem too.

After adding the new $YEAR/$ID.xml file, 'make' will build the
corresponding indexes and HTML/TXT renderings. Ideally the machine which
is hosting the QEMU website would run 'make' after pulling new
commits. In this series, however, I have just commited the rendered
content to git.

In this series I have created notices for all the CVEs I found affecting
QEMU in 2018 that were listed in the Red Hat bugzilla against
Fedora. I'm not entirely confident this is the full set from 2018. I
fully researched the git history for each issue here and suggested
mitigations where practical.

Looking back before 2018, there are ~200 further CVEs I have seen
affecting QEMU. Ideally we'd create records for each of those, but that
will be more time consuming and not a high priority.

Typically it has taken me about 10 minutes on average to create each CVE
file, including time to find historical commits, so the extra work is
quite small, especially compared to actually fixing the code. Ideally
maintainers responsible for the code would create the security notice,
but it could be anyone with an understanding of the issue/code.

Some ideas for future work to take advantage of the machine readable
data format

 - Instead of browsing a list of notices and checking each one to
   see if your version is affected, generate reports for each release
   tag in git listing the flaws that apply.

 - Automated report generation
    - How quickly bugs are fixed since being reported
    - Which areas of code are most affected by flaws (useful
      for distros deciding to cull features)
    - Long term rates of bug reporting (already see 2018
      appears much better than 2016/2017, possibly going
      to be lowest number of CVEs since 2012 !)

Finally, this will all look familiar to anyone following libvirt
as we use the same framework for libvirt security notices:

   https://security.libvirt.org/
   https://libvirt.org/git/?p=3Dlibvirt-security-notice.git;a=3Dlog

I've made a number of changes for QEMU to better suit the way
QEMU works (only 1 git repo to follow, merge commits, integration
with jekyll templating)

Daniel P. Berrang=C3=A9 (4):
  Underline the current page section
  Introduce content and tools for managing security notices
  Add vulnerability reports for 2018
  Update pre-rendered content

 _config.yml                                  |    4 +
 _includes/nav.html                           |    3 +-
 _layouts/secnotice.html                      |   22 +
 assets/css/style-desktop.css                 |    2 +
 assets/css/style.css                         |   47 +
 secnotice/2018/001.html                      | 1043 +++++++++++++++++
 secnotice/2018/001.txt                       |  210 ++++
 secnotice/2018/001.xml                       |  248 ++++
 secnotice/2018/002.html                      | 1044 +++++++++++++++++
 secnotice/2018/002.txt                       |  206 ++++
 secnotice/2018/002.xml                       |  242 ++++
 secnotice/2018/003.html                      |  766 +++++++++++++
 secnotice/2018/003.txt                       |  160 +++
 secnotice/2018/003.xml                       |  191 ++++
 secnotice/2018/004.html                      | 1045 +++++++++++++++++
 secnotice/2018/004.txt                       |  206 ++++
 secnotice/2018/004.xml                       |  243 ++++
 secnotice/2018/005.html                      |  952 ++++++++++++++++
 secnotice/2018/005.txt                       |  191 ++++
 secnotice/2018/005.xml                       |  225 ++++
 secnotice/2018/006.html                      | 1056 ++++++++++++++++++
 secnotice/2018/006.txt                       |  210 ++++
 secnotice/2018/006.xml                       |  247 ++++
 secnotice/2018/007.html                      |  820 ++++++++++++++
 secnotice/2018/007.txt                       |  169 +++
 secnotice/2018/007.xml                       |  201 ++++
 secnotice/2018/008.html                      |  952 ++++++++++++++++
 secnotice/2018/008.txt                       |  191 ++++
 secnotice/2018/008.xml                       |  225 ++++
 secnotice/2018/009.html                      |  952 ++++++++++++++++
 secnotice/2018/009.txt                       |  192 ++++
 secnotice/2018/009.xml                       |  225 ++++
 secnotice/2018/010.html                      |  940 ++++++++++++++++
 secnotice/2018/010.txt                       |  188 ++++
 secnotice/2018/010.xml                       |  223 ++++
 secnotice/2018/011.html                      |  823 ++++++++++++++
 secnotice/2018/011.txt                       |  169 +++
 secnotice/2018/011.xml                       |  199 ++++
 secnotice/2018/index.html                    |   46 +
 secnotice/2018/index.xml                     |   13 +
 secnotice/Makefile                           |   40 +
 secnotice/README-template.md                 |   78 ++
 secnotice/README.md                          |   20 +
 secnotice/_scripts/index-html.xsl            |   72 ++
 secnotice/_scripts/index-xml                 |   28 +
 secnotice/_scripts/notice-html.xsl           |  286 +++++
 secnotice/_scripts/notice-txt.xsl            |  277 +++++
 secnotice/_scripts/report-vulnerable-tags.pl |  135 +++
 secnotice/index.html                         |   46 +
 secnotice/index.xml                          |   13 +
 secnotice/template.xml                       |   50 +
 51 files changed, 16135 insertions(+), 1 deletion(-)
 create mode 100644 _layouts/secnotice.html
 create mode 100644 secnotice/2018/001.html
 create mode 100644 secnotice/2018/001.txt
 create mode 100644 secnotice/2018/001.xml
 create mode 100644 secnotice/2018/002.html
 create mode 100644 secnotice/2018/002.txt
 create mode 100644 secnotice/2018/002.xml
 create mode 100644 secnotice/2018/003.html
 create mode 100644 secnotice/2018/003.txt
 create mode 100644 secnotice/2018/003.xml
 create mode 100644 secnotice/2018/004.html
 create mode 100644 secnotice/2018/004.txt
 create mode 100644 secnotice/2018/004.xml
 create mode 100644 secnotice/2018/005.html
 create mode 100644 secnotice/2018/005.txt
 create mode 100644 secnotice/2018/005.xml
 create mode 100644 secnotice/2018/006.html
 create mode 100644 secnotice/2018/006.txt
 create mode 100644 secnotice/2018/006.xml
 create mode 100644 secnotice/2018/007.html
 create mode 100644 secnotice/2018/007.txt
 create mode 100644 secnotice/2018/007.xml
 create mode 100644 secnotice/2018/008.html
 create mode 100644 secnotice/2018/008.txt
 create mode 100644 secnotice/2018/008.xml
 create mode 100644 secnotice/2018/009.html
 create mode 100644 secnotice/2018/009.txt
 create mode 100644 secnotice/2018/009.xml
 create mode 100644 secnotice/2018/010.html
 create mode 100644 secnotice/2018/010.txt
 create mode 100644 secnotice/2018/010.xml
 create mode 100644 secnotice/2018/011.html
 create mode 100644 secnotice/2018/011.txt
 create mode 100644 secnotice/2018/011.xml
 create mode 100644 secnotice/2018/index.html
 create mode 100644 secnotice/2018/index.xml
 create mode 100644 secnotice/Makefile
 create mode 100644 secnotice/README-template.md
 create mode 100644 secnotice/README.md
 create mode 100644 secnotice/_scripts/index-html.xsl
 create mode 100755 secnotice/_scripts/index-xml
 create mode 100644 secnotice/_scripts/notice-html.xsl
 create mode 100644 secnotice/_scripts/notice-txt.xsl
 create mode 100644 secnotice/_scripts/report-vulnerable-tags.pl
 create mode 100644 secnotice/index.html
 create mode 100644 secnotice/index.xml
 create mode 100644 secnotice/template.xml

--=20
2.17.2
