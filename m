Received: from eggs.gnu.org ([2001:4830:134:3::10]:49840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1g8DTb-00006S-8y
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 19:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1g8DTX-000486-Ug
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 19:56:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37076
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1g8DTX-00044t-Oj
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 19:56:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w94Ns9Ep026261
	for <qemu-devel@nongnu.org>; Thu, 4 Oct 2018 19:56:10 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mwsxwen1m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 19:56:10 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Thu, 4 Oct 2018 19:56:09 -0400
Date: Thu, 4 Oct 2018 20:56:02 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20181004151429.7232-1-crosa@redhat.com>
	<20181004151429.7232-3-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004151429.7232-3-crosa@redhat.com>
Message-Id: <20181004235602.GA24920@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [PATCH 2/7] Acceptance Tests: introduce arch
 parameter and attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

Hi, Cleber.

On Thu, Oct 04, 2018 at 11:14:24AM -0400, Cleber Rosa wrote:
> On a number of different scenarios, such as when choosing a QEMU
> binary to be used on tests (or a image to use to boot a test VM), it's
> useful to define the architecture that should be used.
>
> This introduces both a test parameter and a test instance attribute,
> that will contain such a value.
>
> The selection of the default QEMU binary, if one is not given
> explicitly, has also been changed to look at the arch attribute.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  docs/devel/testing.rst                    | 18 ++++++++++++++++++
>  tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++++---
>  2 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 727c4019b5..4178ae5022 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -659,6 +659,17 @@ vm
>  A QEMUMachine instance, initially configured according to the given
>  ``qemu_bin`` parameter.
>
> +arch
> +~~~~
> +
> +The architecture that will be used on a number of different
> +scenarios.  For instance, when a QEMU binary is not explicitly given,
> +the one selected will depend on this attribute.
> +
> +The ``arch`` attribute will be set to the test parameter of the same
> +name, and if one is not given explicitly, it will default to the
> +system architecture (as given by ``uname``).
> +
>  qemu_bin
>  ~~~~~~~~
>
> @@ -681,6 +692,13 @@ like the following:
>
>    PARAMS (key=qemu_bin, path=*, default=x86_64-softmmu/qemu-system-x86_64) => 'x86_64-softmmu/qemu-system-x86_64
>
> +arch
> +~~~~
> +
> +The architecture that will be used on a number of different scenarios.
> +This parameter has a direct relation with the ``arch`` attribute.  If
> +not given, it will default to None.
> +
>  qemu_bin
>  ~~~~~~~~
>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index d8d5b48dac..9329d9b9ec 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -23,16 +23,22 @@ def is_readable_executable_file(path):
>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
>
>
> -def pick_default_qemu_bin():
> +def pick_default_qemu_bin(arch=None):
>      """
>      Picks the path of a QEMU binary, starting either in the current working
>      directory or in the source tree root directory.
>
> +    :param arch: the arch to use when looking for a QEMU binary (the target
> +                 will match the arch given).  If None (the default) arch
> +                 will be the current host system arch (as given by
> +                 :func:`os.uname`).
> +    :param arch: str

Do you mean

    :type arch: str

?

>      :returns: the path to the default QEMU binary or None if one could not
>                be found
>      :rtype: str or None
>      """
> -    arch = os.uname()[4]
> +    if arch is None:
> +        arch = os.uname()[4]
>      qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
>                                            "qemu-system-%s" % arch)

On ppc64le systems, this can lead to an unexisting path.

For instance, os.uname() returns:

    >>> os.uname()
    ('Linux', 'localhost', '4.15.0-34-generic', '#37-Ubuntu SMP Mon Aug 27 15:18:58 UTC 2018', 'ppc64le')

Then, qemu_bin_relative_path would be set to:

    ppc64le-softmmu/qemu-system-ppc64le

However, the correct path is:

    ppc64-softmmu/qemu-system-ppc64

I'm not sure if ppc64le is the only case where the target name is different from
the OS architecture.

If you decide not to handle this now, at least add a FIXME, if possible.

>      if is_readable_executable_file(qemu_bin_relative_path):
> @@ -47,8 +53,9 @@ def pick_default_qemu_bin():
>  class Test(avocado.Test):
>      def setUp(self):
>          self.vm = None
> +        self.arch = self.params.get('arch', default=os.uname()[4])
>          self.qemu_bin = self.params.get('qemu_bin',
> -                                        default=pick_default_qemu_bin())
> +                                        default=pick_default_qemu_bin(self.arch))
>          if self.qemu_bin is None:
>              self.cancel("No QEMU binary defined or found in the source tree")
>          self.vm = QEMUMachine(self.qemu_bin)
> --
> 2.17.1
>
>

--
Murilo
