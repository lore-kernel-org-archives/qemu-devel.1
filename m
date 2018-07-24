Received: from eggs.gnu.org ([2001:4830:134:3::10]:34186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fht6L-0002aj-UT
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 04:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fht6H-00033y-2N
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 04:55:26 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fht6G-00033i-AF
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 04:55:20 -0400
Received: by mail-wm0-x243.google.com with SMTP id h20-v6so1688275wmb.4
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 01:55:19 -0700 (PDT)
References: <20180717195553.9111-1-alex.bennee@linaro.org>
	<20180717195553.9111-18-alex.bennee@linaro.org>
	<CAK1Eb9kWAni0uWVtxvx-4FpND2iQ2DG22ARjQQwRcKnSzc+_LA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAK1Eb9kWAni0uWVtxvx-4FpND2iQ2DG22ARjQQwRcKnSzc+_LA@mail.gmail.com>
Date: Tue, 24 Jul 2018 09:55:17 +0100
Message-ID: <87fu09t3m2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for 3.0 17/18] docker: perform basic
 binfmt_misc validation in docker.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: cota@braap.org, "Daniel P. Berrange" <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, balrogg@gmail.com, aurelien@aurel32.net, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>


Fam Zheng <famz@redhat.com> writes:

> On Wed, Jul 18, 2018 at 4:02 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>> Setting up binfmt_misc is outside of the scope of the docker.py script
>> but we can at least validate it with any given executable so we have a
>> more useful error message than the sed line of deboostrap failing
>> cryptically.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reported-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  tests/docker/docker.py | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index 523f4b95a2..a3f5b0c1b0 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -112,6 +112,31 @@ def _copy_binary_with_libs(src, dest_dir):
>>              so_path =3D os.path.dirname(l)
>>              _copy_with_mkdir(l , dest_dir, so_path)
>>
>> +
>> +def _check_binfmt_misc(executable):
>> +    """Check binfmt_misc has entry for executable in the right place.
>> +
>> +    The details of setting up binfmt_misc are outside the scope of
>> +    this script but we should at least fail early with a useful
>> +    message if it won't work."""
>> +
>> +    binary =3D os.path.basename(executable)
>> +    binfmt_entry =3D "/proc/sys/fs/binfmt_misc/%s" % (binary)
>> +
>> +    if not os.path.exists(binfmt_entry):
>> +        print ("No binfmt_misc entry for %s" % (binary))
>> +        return False
>> +
>> +    with open(binfmt_entry) as x: entry =3D x.read()
>> +
>> +    qpath =3D "/usr/bin/%s" % (binary)
>
> Is it intended to hardcode this to /usr/bin? I thought we were more
> flexible than that..

That's where we currently copy it. However we are certainly capable of
being more flexible. For example as long at there is an entry visible to
the host file-system with the "F" flag we can actually create and run
docker images without copying QEMU inside the container.

However if we don't we certainly need to copy it to the same place in
the container than it is used outside the container.

>
> Fam
>
>> +    if not re.search("interpreter %s\n" % (qpath), entry):
>> +        print ("binfmt_misc for %s does not point to %s" % (binary, qpa=
th))
>> +        return False
>> +
>> +    return True
>> +
>> +
>>  def _read_qemu_dockerfile(img_name):
>>      # special case for Debian linux-user images
>>      if img_name.startswith("debian") and img_name.endswith("user"):
>> @@ -315,6 +340,11 @@ class BuildCommand(SubCommand):
>>              # Create a docker context directory for the build
>>              docker_dir =3D tempfile.mkdtemp(prefix=3D"docker_build")
>>
>> +            # Validate binfmt_misc will work
>> +            if args.include_executable:
>> +                if not _check_binfmt_misc(args.include_executable):
>> +                    return 1
>> +
>>              # Is there a .pre file to run in the build context?
>>              docker_pre =3D os.path.splitext(args.dockerfile)[0]+".pre"
>>              if os.path.exists(docker_pre):
>> --
>> 2.17.1
>>


--
Alex Benn=C3=A9e
