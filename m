Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8411EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424B422BEA
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/HG2K0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424B422BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc8dZ-00083R-E8
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 10:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc8cm-0007d6-U6
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:26:12 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:38946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc8cl-0000Vc-M0
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:26:12 -0400
Received: by mail-ej1-x644.google.com with SMTP id s3so13272658eji.6
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dn/Itu2iRR4c/BdqRBmu2GBzwUmloM0MTHP0FaS46wE=;
 b=V/HG2K0Lng4dM4E1XXevP9eD/bpZhwik0uQlTIw0S0FycJAMJ4sYmebgm48u8vwSbG
 MeHFwM8KLb6ed82LaKmgEd43Tu2k4o181kzwYzgiC18iGNlltYYILIRyHRcjXxG6TI7N
 ZAgcHImeO2w9e+kTdjigvEQ7dTXNdGFLKtoKdHbeNNPGx6FYOxI3pBOcMDaO203PwEEv
 6rktYw7V+z0wSQ8ITCAjfR7cP38p9/0bk7t6PLnEYRroesh5A6xO+JDo+JESa8+BcddJ
 OfS6Xze6siy3pNBk/rgurDOvWC6gdYcOTEdy6AEUJNxXCCLMuVdGcU/sgvAGgo6UBz5G
 uXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dn/Itu2iRR4c/BdqRBmu2GBzwUmloM0MTHP0FaS46wE=;
 b=ovsWDx1qfYI/tyQdcEa8d2z4ptuyBqc/F7vNdGVtSZdhWVJ6XzucMZkY9/HVWYWNfI
 dPSHlXDK3bfUI7+BLyWqoCvb/xZ7Wx1Fl2qfp03hjTpuivdZF5nhM2cKKIVp1DUUeK/R
 zfjIVU4NVCLiTyE4ngiWpBM6KWp9R4EE6QYJw6/eZqH44s/LUSN46/R0DHRH00QoBKpQ
 L9MCVRq7TiyCl07IINRY6Jk48B328+M2AzsRb2IZa5iuYNGlKvMWV94TqLgwHpUG1NgL
 GMybz0cxTDMJmfW1LZ7xOaPmLsrt58722VAenEIoyOxBQOg1F9vUQ9kpOTbaeFFxO0Np
 pggg==
X-Gm-Message-State: AOAM530/3ofIee5VGwDKCjkhBvDZtGmDEIKdezD0TEekdrLoDGjr15/3
 NgXC5ZD0pWOSFHoSf2Xt4M0XC8wiYec=
X-Google-Smtp-Source: ABdhPJyfmqVxVKwO7Inm4Xo1JGWCokOfdKPX2EGlipOVes3O7p0oJfUYRsd9/9IXF2tlVsj/SRaLYw==
X-Received: by 2002:a17:906:fb0e:: with SMTP id
 lz14mr8118665ejb.237.1590157570044; 
 Fri, 22 May 2020 07:26:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w14sm8244307ejk.13.2020.05.22.07.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 07:26:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4E39C1FF7E;
 Fri, 22 May 2020 15:26:08 +0100 (BST)
References: <20200519132259.405-1-robert.foley@linaro.org>
 <20200519132259.405-6-robert.foley@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v7 05/12] tests/vm: Added configuration file support
In-reply-to: <20200519132259.405-6-robert.foley@linaro.org>
Date: Fri, 22 May 2020 15:26:08 +0100
Message-ID: <87h7w8dp1b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Changes to tests/vm/basevm.py to allow accepting a configuration file
> as a parameter. Allows for specifying VM options such as
> cpu, machine, memory, and arbitrary qemu arguments for specifying options
> such as NUMA configuration.
> Also added an example conf_example_aarch64.yml and conf_example_x86.yml.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  configure                         |  9 ++++++
>  tests/vm/Makefile.include         |  6 ++++
>  tests/vm/basevm.py                | 40 +++++++++++++++++++++++-
>  tests/vm/conf_example_aarch64.yml | 51 +++++++++++++++++++++++++++++++
>  tests/vm/conf_example_x86.yml     | 50 ++++++++++++++++++++++++++++++
>  5 files changed, 155 insertions(+), 1 deletion(-)
>  create mode 100644 tests/vm/conf_example_aarch64.yml
>  create mode 100644 tests/vm/conf_example_x86.yml
>
> diff --git a/configure b/configure
> index a574250524..89d11aa5d4 100755
> --- a/configure
> +++ b/configure
> @@ -950,6 +950,13 @@ do
>      fi
>  done
>=20=20
> +# Check for existence of python3 yaml, needed to
> +# import yaml config files into vm-build.
> +python_yaml=3D"no"
> +if $(python3 -c "import yaml" 2> /dev/null); then
> +    python_yaml=3D"yes"
> +fi
> +
>  : ${smbd=3D${SMBD-/usr/sbin/smbd}}
>=20=20
>  # Default objcc to clang if available, otherwise use CC
> @@ -6581,6 +6588,7 @@ if test "$docs" !=3D "no"; then
>      echo "sphinx-build      $sphinx_build"
>  fi
>  echo "genisoimage       $genisoimage"
> +echo "python_yaml       $python_yaml"
>  echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
>  if test "$slirp" !=3D "no" ; then
>      echo "smbd              $smbd"
> @@ -7642,6 +7650,7 @@ echo "PYTHON=3D$python" >> $config_host_mak
>  echo "SPHINX_BUILD=3D$sphinx_build" >> $config_host_mak
>  echo "SPHINX_WERROR=3D$sphinx_werror" >> $config_host_mak
>  echo "GENISOIMAGE=3D$genisoimage" >> $config_host_mak
> +echo "PYTHON_YAML=3D$python_yaml" >> $config_host_mak
>  echo "CC=3D$cc" >> $config_host_mak
>  if $iasl -h > /dev/null 2>&1; then
>    echo "IASL=3D$iasl" >> $config_host_mak
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 74ab522c55..d9b34eae63 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -43,6 +43,12 @@ endif
>  	@echo "    V=3D1				 - Enable verbose ouput on host and guest commands"
>  	@echo "    QEMU=3D/path/to/qemu		 - Change path to QEMU binary"
>  	@echo "    QEMU_IMG=3D/path/to/qemu-img	 - Change path to qemu-img tool"
> +ifeq ($(PYTHON_YAML),yes)
> +	@echo "    QEMU_CONFIG=3D/path/conf.yml   - Change path to VM configura=
tion .yml file."
> +else
> +	@echo "    (install python3-yaml to enable support for yaml file to con=
figure a VM.)"
> +endif
> +	@echo "                                   See conf_example_*.yml for fi=
le format details."
>=20=20
>  vm-build-all: $(addprefix vm-build-, $(IMAGES))
>=20=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 86ec0df24a..0bc1bad839 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -478,9 +478,43 @@ class BaseVM(object):
>                                cwd=3Dcidir,
>                                stdin=3Dself._devnull, stdout=3Dself._stdo=
ut,
>                                stderr=3Dself._stdout)
> -
>          return os.path.join(cidir, "cloud-init.iso")
>=20=20
> +def parse_config(config, args):
> +    """ Parse yaml config and populate our config structure.
> +        The yaml config allows the user to override the
> +        defaults for VM parameters.  In many cases these
> +        defaults can be overridden without rebuilding the VM."""
> +    if args.config:
> +        config_file =3D args.config
> +    elif 'QEMU_CONFIG' in os.environ:
> +        config_file =3D os.environ['QEMU_CONFIG']
> +    else:
> +        return config
> +    if not os.path.exists(config_file):
> +        raise Exception("config file {} does not exist".format(config_fi=
le))
> +    # We gracefully handle importing the yaml module
> +    # since it might not be installed.
> +    # If we are here it means the user supplied a .yml file,
> +    # so if the yaml module is not installed we will exit with error.
> +    try:
> +        import yaml
> +    except ImportError:
> +        print("The python3-yaml package is needed "\
> +              "to support config.yaml files")
> +        # Instead of raising an exception we exit to avoid
> +        # a raft of messy (expected) errors to stdout.
> +        exit(1)
> +    with open(config_file) as f:
> +        yaml_dict =3D yaml.safe_load(f)
> +
> +    if 'qemu-conf' in yaml_dict:
> +        config.update(yaml_dict['qemu-conf'])
> +    else:
> +        raise Exception("config file {} is not valid"\
> +                        " missing qemu-conf".format(config_file))
> +    return config
> +
>  def parse_args(vmcls):
>=20=20
>      def get_default_jobs():
> @@ -517,6 +551,9 @@ def parse_args(vmcls):
>                        help=3D"run tests with a snapshot")
>      parser.add_option("--genisoimage", default=3D"genisoimage",
>                        help=3D"iso imaging tool")
> +    parser.add_option("--config", "-c", default=3DNone,
> +                      help=3D"Provide config yaml for configuration. "\
> +                           "See config_example.yaml for example.")
>      parser.disable_interspersed_args()
>      return parser.parse_args()
>=20=20
> @@ -528,6 +565,7 @@ def main(vmcls, config=3DNone):
>          if not argv and not args.build_qemu and not args.build_image:
>              print("Nothing to do?")
>              return 1
> +        config =3D parse_config(config, args)
>          logging.basicConfig(level=3D(logging.DEBUG if args.debug
>                                     else logging.WARN))
>          vm =3D vmcls(args, config=3Dconfig)
> diff --git a/tests/vm/conf_example_aarch64.yml b/tests/vm/conf_example_aa=
rch64.yml
> new file mode 100644
> index 0000000000..9d44ae356f
> --- /dev/null
> +++ b/tests/vm/conf_example_aarch64.yml
> @@ -0,0 +1,51 @@
> +#
> +# Example yaml for use by any of the scripts in tests/vm.
> +# Can be provided as an environment variable QEMU_CONFIG
> +#
> +qemu-conf:
> +
> +    # If any of the below are not provided, we will just use the qemu de=
faults.
> +
> +    # Login username and password(has to be sudo enabled)
> +    guest_user: qemu
> +    guest_pass: "qemupass"
> +
> +    # Password for root user can be different from guest.
> +    root_pass: "qemupass"
> +
> +    # If one key is provided, both must be provided.
> +    #ssh_key: /complete/path/of/your/keyfile/id_rsa
> +    #ssh_pub_key: /complete/path/of/your/keyfile/id_rsa.pub
> +
> +    cpu: max
> +    machine: virt,gic-version=3Dmax
> +    memory: 16G
> +
> +    # The below is a example for how to configure NUMA topology with
> +    # 4 NUMA nodes and 2 different NUMA distances.
> +    qemu_args: "-smp cpus=3D16,sockets=3D2,cores=3D8
> +                -numa node,cpus=3D0-3,nodeid=3D0 -numa node,cpus=3D4-7,n=
odeid=3D1
> +                -numa node,cpus=3D8-11,nodeid=3D2 -numa node,cpus=3D12-1=
5,nodeid=3D3
> +                -numa dist,src=3D0,dst=3D1,val=3D15 -numa dist,src=3D2,d=
st=3D3,val=3D15
> +                -numa dist,src=3D0,dst=3D2,val=3D20 -numa dist,src=3D0,d=
st=3D3,val=3D20
> +                -numa dist,src=3D1,dst=3D2,val=3D20 -numa dist,src=3D1,d=
st=3D3,val=3D20"
> +
> +    # By default we do not set the DNS.
> +    # You override the defaults by setting the below.
> +    #dns: 1.234.567.89
> +
> +    # By default we will use a "block" device, but
> +    # you can also boot from a "scsi" device.
> +    # Just keep in mind your scripts might need to change
> +    # As you will have /dev/sda instead of /dev/vda (for block device)
> +    boot_dev_type: "block"
> +
> +    # By default the ssh port is not fixed.
> +    # A fixed ssh port makes it easier for automated tests.
> +    #ssh_port: 5555
> +
> +    # To install a different set of packages, provide a command to issue
> +    #install_cmds: "apt-get update ; apt-get build-dep -y qemu"
> +
> +    # Or to skip the install entirely, just provide ""
> +    #install_cmds: ""
> diff --git a/tests/vm/conf_example_x86.yml b/tests/vm/conf_example_x86.yml
> new file mode 100644
> index 0000000000..78d3f5830f
> --- /dev/null
> +++ b/tests/vm/conf_example_x86.yml
> @@ -0,0 +1,50 @@
> +#
> +# Example yaml for use by any of the x86 based scripts in tests/vm.
> +# Can be provided as an environment variable QEMU_CONFIG
> +#
> +qemu-conf:
> +
> +    # If any of the below are not provided, we will just use the qemu de=
faults.
> +
> +    # Login username and password(has to be sudo enabled)
> +    guest_user: "qemu"
> +    guest_pass: "qemupass"
> +
> +    # Password for root user can be different from guest.
> +    root_pass: "qemupass"
> +
> +    # Provide default ssh keys of current user.
> +    # You need to edit the below for your user.
> +    #ssh_key_file: /home/<user>/.ssh/id_rsa
> +    #ssh_pub_key_file: /home/<user>/.ssh/id_rsa.pub
> +
> +    cpu: max
> +    machine: pc
> +    memory: 8G
> +
> +    # The below is a example for how to configure NUMA topology with
> +    # 4 NUMA nodes and 2 different NUMA distances.
> +    qemu_args: "-smp cpus=3D8,sockets=3D2,cores=3D4
> +                -object memory-backend-ram,size=3D4G,policy=3Dbind,host-=
nodes=3D0,id=3Dram-node0
> +                -object memory-backend-ram,size=3D4G,policy=3Dbind,host-=
nodes=3D0,id=3Dram-node1
> +                -object memory-backend-ram,size=3D4G,policy=3Dbind,host-=
nodes=3D1,id=3Dram-node2
> +                -object memory-backend-ram,size=3D4G,policy=3Dbind,host-=
nodes=3D1,id=3Dram-node3
> +                -numa node,cpus=3D0-1,nodeid=3D0 -numa node,cpus=3D2-3,n=
odeid=3D1
> +                -numa node,cpus=3D4-5,nodeid=3D2 -numa node,cpus=3D6-7,n=
odeid=3D3
> +                -numa dist,src=3D0,dst=3D1,val=3D15 -numa dist,src=3D2,d=
st=3D3,val=3D15
> +                -numa dist,src=3D0,dst=3D2,val=3D20 -numa dist,src=3D0,d=
st=3D3,val=3D20
> +                -numa dist,src=3D1,dst=3D2,val=3D20 -numa dist,src=3D1,d=
st=3D3,val=3D20"
> +
> +    # By default we do not set the DNS.
> +    # You override the defaults by setting the below.
> +    #dns: "1.234.567.89"
> +
> +    # By default we will use a "block" device, but
> +    # you can also boot from a "scsi" device.
> +    # Just keep in mind your scripts might need to change
> +    # As you will have /dev/sda instead of /dev/vda (for block device)
> +    boot_dev_type: "block"
> +
> +    # By default the ssh port is not fixed.
> +    # A fixed ssh port makes it easier for automated tests.
> +    ssh_port: 5555


--=20
Alex Benn=C3=A9e

