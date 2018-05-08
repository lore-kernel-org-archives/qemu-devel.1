Received: from eggs.gnu.org ([2001:4830:134:3::10]:45711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dunlapg@gmail.com>) id 1fG3xD-0005VY-Er
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dunlapg@gmail.com>) id 1fG3x7-0005L8-GK
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:50:59 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dunlapg@gmail.com>) id 1fG3x7-0005KN-98
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:50:53 -0400
Received: by mail-qk0-x244.google.com with SMTP id c11so1200350qkm.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 07:50:50 -0700 (PDT)
MIME-Version: 1.0
Sender: dunlapg@gmail.com
In-Reply-To: <20180504210001.GB30250@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
	<20180504210001.GB30250@redhat.com>
From: George Dunlap <dunlapg@umich.edu>
Date: Tue, 8 May 2018 15:50:49 +0100
Message-ID: <CAFLBxZYO7Yeje8HROjJY9P=9bEQ8RCBhA9fqbGTXN_87U5sowA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 0/3] Document intent for
 supported build platforms and bump min glib to 2.42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel <xen-devel@lists.xenproject.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Olaf Hering <olaf@aepfle.de>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Ian Jackson <ian.jackson@eu.citrix.com>, Jan Beulich <JBeulich@suse.com>, Juergen Gross <jgross@suse.com>, Anthony Perard <anthony.perard@citrix.com>

On Fri, May 4, 2018 at 10:00 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> CC'ing xen-devel in case Xen maintainers have a need for something that
> will that conflict with this proposal wrt supported build platforms.

Thanks for the heads-up.  CC'ing some more people who usually have
opinions on this sort of thing.

>
> On Fri, May 04, 2018 at 05:00:23PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> This short series is a followup the discussions around min glib version
>> when Olaf found we had accidentally increased the min glib by using a
>> newer function:
>>
>>   https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg02699.html
>>
>> Some key points from that thread
>>
>>   - Although we have a docker job that tries to test the min glib
>>     version is adhered to, that's only run post-build, not by Peter's
>>     merge tests, nor by patchew.
>>
>>   - The docker min glib test failed to detect the problem anyway
>>     because RHEL had backported the symbol in question.
>>
>>   - The docker min glib test only builds with certain configure
>>     options so isn't foolproof.
>>
>>   - The modern distros we implicitly care about have way newer glib
>>     than 2.22
>>
>>   - Peter's OS-X build host previously had 2.22, but after switching
>>     from fink to homebrew now has 2.56
>>
>>   - I suggested following libvirt's lead in writing a policy for how
>>     we pick supported OS targets to inform maintainers when min versions
>>     can be increased.
>>
>> This series writes such a document largely based on one I wrote for
>> libvirt with a few changes, largely around OS-X and *BSD. Note it
>> is not meant to be an exhaustive list of distros we'll build on, rather
>> a representative selection, so that we can identify the range of 3rd
>> party library versions we need to care about. So if your favourite
>> distro is missing, dont be alarmed, as it probably ships similar
>> vintage software to one of those listed - if not feel free to suggest
>> additions.
>>
>> Based on that doc and https://repology.org/metapackage/glib/versions,
>> I identified that we could feasibly set min glib to 2.42. Note that
>> this would be dropping RHEL-6 as a build host (RHEL-6.0 came out in
>> 2010 so that's reasonable to drop IMHO). It would still cover 2 major
>> Debian versions and 2 most recent Ubuntu LTS (16.04, 18.04, but *not*
>> 14.04). This min glib lets us remove almost all our compat code.
>>
>> Most interestingly, thanks tothe new min version being greater than
>> 2.32, we can now use GLIB_VERSION_MAX_ALLOWED to validate the correct
>> API usage according to our min version:
>>
>>   https://developer.gnome.org/glib/stable/glib-Version-Information.html#=
GLIB-VERSION-MAX-ALLOWED:CAPS
>>
>> This means that *all* our CI jobs & developer builds will be enforcing
>> the min version, so means very many more conditionally built features
>> will get their build validated against min glib version. This would
>> do a much better job of catching mistakes than our min-glib docker
>> job, making that obsolete.
>>
>> Daniel P. Berrang=C3=A9 (3):
>>   qemu-doc: provide details of supported build platforms
>>   glib: bump min required glib library version to 2.42
>>   glib: enforce the minimum required version and warn about old APIs

Two responses from me.

With my Xen maintainer hat on: I wouldn't feel justified, personally,
in asking another project to continue supporting older versions.  If
we didn't want to bump our own glib version, we would have to disable
"upstream" QEMU (as opposed to Xen's old qemu fork) for older versions
of glib.

That said, when we've had similar discussions for our own project,
we've generally aimed at supporting all major currently-supported
distros, which would include RHEL 6 / CentOS 6.

Tailing into that, with my CentOS package maintainer hat on: You said
that the code in question compiled on RHEL 6 because RH had backported
the function in question.  Will QEMU continue to actually compile on
RHEL 6 / CentOS 6?  I.e., will configure be checking for that
function, or only checking for the version number?

If the former, then the CentOS 6 Xen packages won't be affected.  If
the latter, then at some point I'll have to stop updating the Xen
version for CentOS 6 -- but as the CentOS 6 EOL is coming up in 2020,
it shouldn't be too much of a hardship.

 -George
