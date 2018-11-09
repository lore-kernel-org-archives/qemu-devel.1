Received: from eggs.gnu.org ([2001:4830:134:3::10]:40310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL9pB-0000nP-TD
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL9p7-0002KV-Rx
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:40:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gL9p7-0002HN-GM
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:39:57 -0500
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-2-crosa@redhat.com>
	<20181109154908.GW12503@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <2426066f-37b0-acb8-f5f9-02fec9b6d7fa@redhat.com>
Date: Fri, 9 Nov 2018 11:39:32 -0500
MIME-Version: 1.0
In-Reply-To: <20181109154908.GW12503@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] configure: keep track of Python version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>



On 11/9/18 10:49 AM, Eduardo Habkost wrote:
> On Fri, Nov 09, 2018 at 10:07:07AM -0500, Cleber Rosa wrote:
>> Some functionality is dependent on the Python version
>> detected/configured on configure.  While it's possible to run the
>> Python version later and check for the version, doing it once is
>> preferable.  Also, it's a relevant information to keep in build logs,
>> as the overall behavior of the build can be affected by it.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  configure | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 74e313a810..67fff0290d 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1740,6 +1740,9 @@ if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
>>        "Use --python=/path/to/python to specify a supported Python."
>>  fi
>>  
>> +# Preserve python version since some functionality is dependent on it
>> +python_version=$($python -V 2>&1 | sed -e 's/Python\ //')
> 
> What about:
>   $($python -c 'import sys;print(sys.version)')
> ?
> 
> It is very verbose, but I think that's a good thing.
> 

Well, something like:

'3.7.1 (default, Oct 23 2018, 18:19:07) \n[GCC 8.2.1 20180801 (Red Hat
8.2.1-2)]'

Doesn't qualify as simply the Python *version*.  The documentation[1]
puts it clearly: "A string containing the version number of the Python
interpreter plus additional information on the build number and compiler
used. This string is displayed when the interactive interpreter is started."

I can't see how the compiler used on the Python build, or the build
date, can be significant to someone debugging the type of Python code
that will be on QEMU.

>> +
>>  # Suppress writing compiled files
>>  python="$python -B"
>>  
>> @@ -5918,7 +5921,7 @@ echo "LDFLAGS           $LDFLAGS"
>>  echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
>>  echo "make              $make"
>>  echo "install           $install"
>> -echo "python            $python"
>> +echo "python            $python ($python_version)"
>>  if test "$slirp" = "yes" ; then
>>      echo "smbd              $smbd"
>>  fi
>> @@ -6823,6 +6826,7 @@ echo "INSTALL_DATA=$install -c -m 0644" >> $config_host_mak
>>  echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
>>  echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
>>  echo "PYTHON=$python" >> $config_host_mak
>> +echo "PYTHON_VERSION=$python_version" >> $config_host_mak
> 
> The output of "python -V" and "sys.version" seems to be meant for
> humans, not software.  If we really want something to be used in
> conditional makefile rules, I'd prefer to use sys.version_info.
> e.g.:
> 

"Python -V" is quite different from "sys.version".  Indeed it includes
the "Python " prefix, but that's all, everything else is the version number.

>   python_major_version="$($python -c 'import sys;print(sys.version_info[0])')"
>   echo "PYTHON_MAJOR_VERSION=$python_major_version"
> 
> 

No, I'm actually interested in the other version components, not just
the major version.  As I tried to explain in another thread, differences
from Python 3.0 to 3.4 are many, and from 3.4 to 3.6 and so on.

Then, we can either introduce "PYTHON_MAJOR_VERSION",
"PYTHON_MINOR_VERSION", "PYTHON_RELEASE" of sorts, or just have a single
dot separated version string.

- Cleber

[1] - https://docs.python.org/3/library/sys.html#sys.version

>>  echo "CC=$cc" >> $config_host_mak
>>  if $iasl -h > /dev/null 2>&1; then
>>    echo "IASL=$iasl" >> $config_host_mak
>> -- 
>> 2.19.1
>>
> 
