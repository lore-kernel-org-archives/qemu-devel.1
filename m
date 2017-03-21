Received: from eggs.gnu.org ([2001:4830:134:3::10]:51803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu.bugs@whitewinterwolf.com>) id 1cqIwL-0006Nm-GZ
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu.bugs@whitewinterwolf.com>) id 1cqIwI-0002yC-8B
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:31:05 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:34397)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu.bugs@whitewinterwolf.com>)
	id 1cqIwH-0002xl-Nr
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:31:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Mar 2017 13:30:56 +0100
From: Simon <qemu.bugs@whitewinterwolf.com>
In-Reply-To: <20170320095533.GB3792@redhat.com>
References: <11569d75b61122820f186a32cdd20689@whitewinterwolf.com>
	<20170315144124.GP7770@redhat.com>
	<23d89ab3bd16ebf7a864ab75c300de7b@whitewinterwolf.com>
	<CAFEAcA-9GXiS+ByQgo+=tQ-_ZGR5egDcZMurEyfiA9vPkE9O9w@mail.gmail.com>
	<20170315180822.GU7770@redhat.com>
	<CAFEAcA-WzT80S_NJb8rSALspBZcCQbT7eounFn9HusjtLWoi_Q@mail.gmail.com>
	<20170316102652.GG15193@redhat.com>
	<14585f602461dbefb3adaf16591ce5e5@whitewinterwolf.com>
	<20170320095533.GB3792@redhat.com>
Message-ID: <2dc320e84befdfb8d96f7ec764a1c8e2@whitewinterwolf.com>
Subject: Re: [Qemu-devel] [Bug 1217339] [PATCH v2] Unix signal to send
 ACPI-shutdown to Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Daniel P. Berrange:
> On Sat, Mar 18, 2017 at 02:41:16PM +0100, Simon wrote:
>> Hi,
>> 
>> The patch below adds the new command-line option `-powerdown' which
>> changes the behavior for both SIGHUP and SIGINT signals to cause a 
>> clean
>> power down of the guest using an ACPI shutdown request.
> 
> If you need to add command line arguments IMHO this feature becomes
> much less interesting - just use the QEMU monitor instead of inventing
> an adhoc way to achieve something the monitor already does. The value 
> of
> using a signal handler comes from the fact that it would be 
> unconditionally
> available no matter what command line args were added.

Hi Daniel,

Thank you for taking the time to answer me.

I am currently using the monitor to achieve this functionality, and this
boils down into doing something similar to this:

--------- 8< ----------------
if ! type 'socat' >/dev/null 2>&1
then
     echo "You must install 'socat'." >&2
     exit 1
fi
files=$( ps -e -o args | awk '$1 ~ /qemu-system-/' \
     | sed 's/.* -monitor unix:\([^,]*\).*/\1/;t;s/.*//' )
IFS='
'
for f in $files
do
     echo 'system_powerdown' | socat "UNIX-CONNECT:${f}" -
done
--------- 8< ----------------

In other words I check that required software is properly installed,
parse `ps' output to extract the path to the monitor socket file when it
is available, and pipe the `system_powerdown' command into it to
cleanly shut the VM down.

As a matter of comparison, here the same functionality implemented using
Unix signals instead of the monitor socket files:

--------- 8< ----------------
pkill -HUP qemu-system-
--------- 8< ----------------

Maybe it is just my own opinion, but I find the second approach cleaner
and more reliable.

Regarding the fact that it would require a specific parameter to be
enabled, I already use several parameters on a systematic basis with
Qemu (enable KVM, the USB tablet, set the keyboard layout, etc.).
I don't see the fact of adding a supplementary one to this set as an
annoyance.

On the contrary, I love Qemu's versatility and all these parameters are
here just to let users personalize Qemu behavior to best suit the way
they use it.

Regards,
Simon.
