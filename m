Received: from eggs.gnu.org ([2001:4830:134:3::10]:44132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1du4xR-0001Bk-95
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1du4xK-0004JP-Ue
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:56:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1du4xK-0004Ik-J5
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:55:58 -0400
Date: Mon, 18 Sep 2017 19:55:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170918225552.GM10621@localhost.localdomain>
References: <20170918215719.16415-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170918215719.16415-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel]  [RFC v1 0/2]  Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, marcel@redhat.com

On Mon, Sep 18, 2017 at 06:57:19PM -0300, Philippe Mathieu-Daud=E9 wrote:
> add a property to restrict the CPU for SoCs once on machine creation an=
d avoid
> duplicate code in each board.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

The valid_cpu_types approach implemented by Alistair is more
generic:
  Subject: [Qemu-devel] [RFC v1 0/2]  Add a valid_cpu_types property
  Message-ID: <cover.1504656490.git.alistair.francis@xilinx.com>

With it, boards that don't support other CPUs just need to set
valid_cpu_types =3D { default_cpu_type }.

> ---
> Based-on: 1505318697-77161-6-git-send-email-imammedo@redhat.com
>=20
>  include/hw/boards.h |  3 +++
>  vl.c                | 11 +++++++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 6b67adaef6..20dc0a0ab9 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -129,6 +129,8 @@ typedef struct {
>   *    specifies default CPU_TYPE, which will be used for parsing targe=
t
>   *    specific features and for creating CPUs if CPU name wasn't provi=
ded
>   *    explicitly at CLI
> + * @is_system_on_chip:
> + *    If true, board does not support other CPUs than default_cpu_type=
.
>   * @minimum_page_bits:
>   *    If non-zero, the board promises never to create a CPU with a pag=
e size
>   *    smaller than this, so QEMU can use a more efficient larger page
> @@ -182,6 +184,7 @@ struct MachineClass {
>      const char *hw_version;
>      ram_addr_t default_ram_size;
>      const char *default_cpu_type;
> +    bool is_system_on_chip;
>      bool option_rom_has_mr;
>      bool rom_file_has_mr;
>      int minimum_page_bits;
> diff --git a/vl.c b/vl.c
> index fb6a700e55..6e59ffa856 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4717,10 +4717,21 @@ int main(int argc, char **argv, char **envp)
>      current_machine->cpu_model =3D cpu_model;
> =20
> =20
> +    if (machine_class->is_system_on_chip && !machine_class->default_cp=
u_type) {
> +        error_report("System-on-Chip must have a default CPU type");
> +        exit(1);
> +    }
>      /* parse features once if machine provides default cpu_type */
>      if (machine_class->default_cpu_type) {
>          current_machine->cpu_type =3D machine_class->default_cpu_type;
>          if (cpu_model) {
> +            if (machine_class->is_system_on_chip) {
> +                if (strcmp(cpu_model, machine_class->default_cpu_type)=
 !=3D 0) {
> +                    error_report("This board can only be used with CPU=
 %s",
> +                                 machine_class->default_cpu_type);
> +                    exit(1);
> +                }
> +            }
>              current_machine->cpu_type =3D
>                  cpu_parse_cpu_model(machine_class->default_cpu_type, c=
pu_model);
>          }
> --=20
> 2.14.1
>=20

--=20
Eduardo
