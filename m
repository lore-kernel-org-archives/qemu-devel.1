Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65397C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2948E20702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpvPPsly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2948E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3g9-0001PS-C3
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iw3fA-0000Pu-AH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iw3f8-0008Hc-Jv
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:38:44 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iw3f8-0008Gw-Bh
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:38:42 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so6639149wmb.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 04:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cMVNBphhsS1inpTqEUn5qmv858oXAbQx07v7eyUgu4Q=;
 b=hpvPPslyg1caYFs3eQYbrdmKQQikd73bqX2PzdDfCK+vrKrVOhsHRN9BylawK2Bx8g
 QAFjEWok3nz8xINO+GKOQE3CusnviAhLwjU1MeyzlQFIbflPikrDW2BukfXwUjJOBxLH
 13EjZ9F8r/FRLt+cfWJYlW4JYx/mIciuF48PWXReY1VdGks/BRWMJDKoowcw5fDb6I83
 MpS6t2iM2tYRMhzoFM21ImrkJC4HYje3iDcGKX2Ds5+YsmZEpkdb4YQk9DDvJCnt7z1I
 0JtOkC9+G6y0fz87d5wGb+KjOFUoypDAvNuhR382SmVgBq3M518BKf4BeltxKQr3lvWw
 ENGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cMVNBphhsS1inpTqEUn5qmv858oXAbQx07v7eyUgu4Q=;
 b=Edvk+ClfGEQXcwcasJzoUTF3BsKgoS/7OTDrkGnJxanobIKh6g0LPfdYFc/vGmClgw
 lhjA4RKGnUXmuUj0+6n1NE9zPGfDLIynWQ6kTCIzHI5ihbURZws2RJD92m3UIqutcWmD
 9wIZWS9qcQJAUcs30Olh6gXDu+3DOMYp0pCqDRxwr40/swP3W7PvCBSpslGg25nAZfiP
 ARgpj34J5VMrsm1lEKShX7JvOH2/FpQrmx81myB9JX3m5m/Oeke/DtsUncg+PoXG80rk
 xvjcwoVo5gjJWqXblJ4WoSqOB2ijttAnomPyWkUeDzQ7nxLfzZhBeUx8jBADeYUQaavr
 xB0w==
X-Gm-Message-State: APjAAAWjsPT2c2RaTn8SnjsjLGejay7p4dX9WV7rSt5A0msUC414xGUf
 X2gKIvLihT9Zo+0W1KwMmb2gnQ==
X-Google-Smtp-Source: APXvYqxF4RK9EOVDr0yE9imlT4t5siDRfmay4KsAytfjk9Fl4dzrz4gNEQfUYekdHJ9YtF2tO9zClg==
X-Received: by 2002:a7b:ce18:: with SMTP id m24mr2522379wmc.123.1580128720606; 
 Mon, 27 Jan 2020 04:38:40 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm20776241wro.85.2020.01.27.04.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 04:38:39 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 933831FF87;
 Mon, 27 Jan 2020 12:38:38 +0000 (GMT)
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-6-robert.foley@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 5/8] tests/vm: Added configuration file support
In-reply-to: <20200124165335.422-6-robert.foley@linaro.org>
Date: Mon, 27 Jan 2020 12:38:38 +0000
Message-ID: <87pnf5f50x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, peter.puhov@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Changes to tests/vm/basevm.py to allow accepting a configuration file
> as a parameter. Allows for specifying VM options such as
> cpu, machine, memory, and arbitrary qemu arguments for specifying options
> such as NUMA configuration.
> Also added an example config_example.yml.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> ---
>  tests/vm/basevm.py          | 60 +++++++++++++++++++++++++++++++++++++
>  tests/vm/config_example.yml | 52 ++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 tests/vm/config_example.yml
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index ec92c8f105..08a8989ac0 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -31,6 +31,7 @@ import tempfile
>  import shutil
>  import multiprocessing
>  import traceback
> +import yaml
>=20=20
>  SSH_KEY_FILE =3D os.path.join(os.path.dirname(__file__),
>                 "..", "keys", "id_rsa")
> @@ -396,6 +397,61 @@ class BaseVM(object):
>      def qmp(self, *args, **kwargs):
>          return self._guest.qmp(*args, **kwargs)
>=20=20
> +
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
> +    with open(config_file) as f:
> +        yaml_dict =3D yaml.safe_load(f)
> +    if 'target-conf' in yaml_dict:
> +        target_dict =3D yaml_dict['target-conf']
> +        if 'username' in target_dict and target_dict['username'] !=3D 'r=
oot':
> +            config['guest_user'] =3D target_dict['username']
> +        if 'password' in target_dict:
> +            config['root_pass'] =3D target_dict['password']
> +            config['guest_pass'] =3D target_dict['password']

This seems like impedance matching between two dictionaries. Surely it
would be nicer for the config to be read in fully formed and referable by
the rest of the code. We can also change the internal references.

> +        if any (k in target_dict for k in ("ssh_key","ssh_pub_key")) and=
 \
> +           not all (k in target_dict for k in ("ssh_key","ssh_pub_key")):
> +            missing_key =3D "ssh_pub_key" \
> +              if 'ssh_key' in target_dict else "ssh_key"
> +            raise Exception("both ssh_key and ssh_pub_key required. "
> +                            "{} key is missing.".format(missing_key))

I guess validation has to be done at some time.. but

> +        if 'ssh_key' in target_dict:
> +            config['ssh_key_file'] =3D target_dict['ssh_key']
> +            if not os.path.exists(config['ssh_key_file']):
> +                raise Exception("ssh key file not found.")
> +        if 'ssh_pub_key' in target_dict:
> +            config['ssh_pub_key_file'] =3D target_dict['ssh_pub_key']
> +            if not os.path.exists(config['ssh_pub_key_file']):
> +                raise Exception("ssh pub key file not found.")

here we are both munging dictionaries again before checking the data.
Given we bail with an exception I'm now rethinking if it makes sense to
validate up here. It depends on how many places in the code expect to
use this data.

> +        if 'machine' in target_dict:
> +            config['machine'] =3D target_dict['machine']
> +        if 'qemu_args' in target_dict:
> +            qemu_args =3D target_dict['qemu_args']
> +            qemu_args =3D qemu_args.replace('\n', ' ').replace('\r', '')
> +            config['extra_args'] =3D qemu_args.split(' ')
> +        if 'memory' in target_dict:
> +            config['memory'] =3D target_dict['memory']
> +        if 'dns' in target_dict:
> +            config['dns'] =3D target_dict['dns']
> +        if 'cpu' in target_dict:
> +            config['cpu'] =3D target_dict['cpu']
> +        if 'ssh_port' in target_dict:
> +            config['ssh_port'] =3D target_dict['ssh_port']
> +        if 'install_cmds' in target_dict:
> +            config['install_cmds'] =3D target_dict['install_cmds']
> +    return config
> +
>  def parse_args(vmcls):
>=20=20
>      def get_default_jobs():
> @@ -430,6 +486,9 @@ def parse_args(vmcls):
>                        help=3D"Interactively run command")
>      parser.add_option("--snapshot", "-s", action=3D"store_true",
>                        help=3D"run tests with a snapshot")
> +    parser.add_option("--config", "-c", default=3DNone,
> +                      help=3D"Provide config yaml for configuration. "\
> +                           "See config_example.yaml for example.")
>      parser.disable_interspersed_args()
>      return parser.parse_args()
>=20=20
> @@ -441,6 +500,7 @@ def main(vmcls, config=3DNone):
>          if not argv and not args.build_qemu and not args.build_image:
>              print("Nothing to do?")
>              return 1
> +        config =3D parse_config(config, args)
>          logging.basicConfig(level=3D(logging.DEBUG if args.debug
>                                     else logging.WARN))
>          vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs, config=3Dcon=
fig)
> diff --git a/tests/vm/config_example.yml b/tests/vm/config_example.yml
> new file mode 100644
> index 0000000000..0a1fec3824
> --- /dev/null
> +++ b/tests/vm/config_example.yml
> @@ -0,0 +1,52 @@
> +#
> +# Example yaml for use by any of the scripts in tests/vm.
> +# Can be provided as an environment variable QEMU_CONFIG
> +#
> +target-conf:
> +
> +    # If any of the below are not provided, we will just use the qemu de=
faults.
> +
> +    # Login username (has to be sudo enabled)
> +    #username: qemu
> +
> +    # Password is used by root and default login user.
> +    #password: "qemupass"
> +
> +    # If one key is provided, both must be provided.
> +    #ssh_key: /complete/path/of/your/keyfile/id_rsa
> +    #ssh_pub_key: /complete/path/of/your/keyfile/id_rsa.pub
> +
> +    cpu: max
> +    machine: virt,gic_version=3D3
> +    memory: 16G
> +
> +    # The below is an example for how to configure NUMA topology with
> +    # 4 NUMA nodes and 2 different NUMA distances.
> +    qemu_args: "-smp cpus=3D16,sockets=3D2,cores=3D8
> +                -object memory-backend-ram,size=3D4G,policy=3Dbind,host-=
nodes=3D0,id=3Dram-node0
> +                -object memory-backend-ram,size=3D4G,policy=3Dbind,host-=
nodes=3D0,id=3Dram-node1
> +                -object memory-backend-ram,size=3D4G,policy=3Dbind,host-=
nodes=3D1,id=3Dram-node2
> +                -object memory-backend-ram,size=3D4G,policy=3Dbind,host-=
nodes=3D1,id=3Dram-node3
> +                -numa node,memdev=3Dram-node0,cpus=3D0-3,nodeid=3D0 -num=
a node,memdev=3Dram-node1,cpus=3D4-7,nodeid=3D1
> +                -numa node,memdev=3Dram-node2,cpus=3D8-11,nodeid=3D2 -nu=
ma node,memdev=3Dram-node3,cpus=3D12-15,nodeid=3D3
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
> +    #boot_dev_type: "scsi"
> +
> +    # By default the ssh port is not fixed.
> +    # A fixed ssh port makes it easier for automated tests.
> +    #ssh_port: 5555
> +
> +    # To install a different set of packages, provide a command to issue
> +    #install_cmds: "apt-get update ; apt-get build-dep -y qemu"
> +

Having the example is great. It would be nice to see at least one of the
others converted to a config driven approach as well - is the config
driven approach going to reduce duplication across the various bits of
VM configuring python? Should everything be config driven? Are we in
danger of re-inventing an exiting tooling?

--=20
Alex Benn=C3=A9e

